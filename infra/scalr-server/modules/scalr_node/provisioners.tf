resource "random_id" "admin_password" {
  byte_length = 8
}

locals {
  scalr_etc_template_dir = "${path.module}/configs/etc_template"
  scalr_certs_dir        = "${path.module}/configs/certs"
  certs_path             = "/opt/scalr-server/certs"
  admin_password         = random_id.admin_password.hex
}

locals {
  scalr_package_name = var.scalr_package_name != "" ? var.scalr_package_name : "scalr-server"
  fatmouse_revision  = var.fatmouse_revision != "" ? var.fatmouse_revision : "master"
  int_scalr_revision = var.int_scalr_revision != "" ? var.int_scalr_revision : "master"
  installer_revision = var.installer_revision != "" ? var.installer_revision : "staging"
}

locals {
  license_json_content = file("${path.module}/configs/license.json")
}

data "template_file" "scalr_server_rb" {
  template = file("${path.module}/configs/scalr-server.rb.tpl")

  vars = {
    endpoint_host     = var.hostname
    product_mode      = var.product_mode != "" ? var.product_mode : "iacp"
    ssl_cert_path     = "${local.certs_path}/nginx/_wildcard.devel.scalr.com.pem"
    ssl_key_path      = "${local.certs_path}/nginx/_wildcard.devel.scalr.com-key.pem"
    ssl_extra_ca_file = "${local.certs_path}/rootCA.pem"
    http_proxy        = var.http_proxy
    no_proxy          = ""
  }
}

data "template_file" "scalr_server_secrets_json" {
  template = file("${path.module}/configs/scalr-server-secrets.json.tpl")
  vars = {
    scalr_id       = var.scalr_id
    admin_password = local.admin_password
  }
}

resource "null_resource" "set_environment_variables" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -e",
      "sudo rm -rf /etc/environment",
      "sudo touch /etc/environment",
      "sudo bash -c 'echo https_proxy=${var.http_proxy} >> /etc/environment'",
      "sudo bash -c 'echo http_proxy=${var.http_proxy} >> /etc/environment'",
      "sudo bash -c 'echo HTTPS_PROXY=${var.http_proxy} >> /etc/environment'",
      "sudo bash -c 'echo HTTP_PROXY=${var.http_proxy} >> /etc/environment'",
    ]
  }

  depends_on = [
    google_compute_instance.scalr_node
  ]
  triggers = {
    instance_id = google_compute_instance.scalr_node.instance_id
    http_proxy  = var.http_proxy
  }
}

resource "null_resource" "install_scalr_server_package" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",

      # Install third-party packages
      "sudo rm -rf /etc/yum.repos.d/PGDG.repo",
      "sudo yum install -y https://centos7.iuscommunity.org/ius-release.rpm || true",
      "sudo yum install -y gcc-c++ make telnet lnav git jq unzip",
      "sudo curl -sL https://rpm.nodesource.com/setup_13.x | sudo -E bash -",
      "sudo yum install -y nodejs",

      # Install scalr-server package
      "sudo rm -rf /etc/boto.cfg",
      "sudo curl -s https://${var.packagecloud_token}:@packagecloud.io/install/repositories/scalr/scalr-server-alt/script.rpm.sh | sudo bash",
      "sudo yum --assumeyes install -q ${local.scalr_package_name}",
    ]
  }

  depends_on = [
    google_compute_instance.scalr_node,
    null_resource.set_environment_variables
  ]
  triggers = {
    instance_id        = google_compute_instance.scalr_node.instance_id,
    scalr_package_name = var.scalr_package_name,
  }
}

resource "null_resource" "configure_scalr_server_package" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "file" {
    content     = data.template_file.scalr_server_rb.rendered
    destination = "/tmp/scalr-server.rb"
  }
  provisioner "file" {
    content     = local.license_json_content
    destination = "/tmp/license.json"
  }
  provisioner "file" {
    content     = data.template_file.scalr_server_secrets_json.rendered
    destination = "/tmp/scalr-server-secrets.json"
  }
  provisioner "file" {
    source      = local.scalr_certs_dir
    destination = "/tmp/"
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",

      # Disable selinux
      # see: https://github.com/moby/moby/issues/39109
      "sudo setenforce 0",

      # Configure /etc/scalr-server
      "sudo mkdir -p /etc/scalr-server",
      "sudo mv /tmp/scalr-server.rb /etc/scalr-server/",
      "sudo mv /tmp/license.json /etc/scalr-server/",
      "sudo mv -vn /tmp/scalr-server-secrets.json /etc/scalr-server/", # ignore if secrets already exists

      # Setup Nginx certificates
      "sudo rm -rf /opt/scalr-server/certs",
      "sudo mkdir -p /opt/scalr-server/certs",
      "sudo mv /tmp/certs/* /opt/scalr-server/certs",
      "sudo rm -rf /tmp/certs/"
    ]
  }

  depends_on = [
    google_compute_instance.scalr_node,
    null_resource.set_environment_variables,
    null_resource.install_scalr_server_package,
  ]
  triggers = {
    instance_id             = google_compute_instance.scalr_node.instance_id
    scalr_server_package_id = null_resource.install_scalr_server_package.id
    scalr_server_rb         = data.template_file.scalr_server_rb.rendered
    license_json            = local.license_json_content
  }
}

resource "null_resource" "update_scalr_server_cookbook" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "sudo rm -rf installer-ng",
      "git clone https://${var.github_token}@github.com/Scalr/installer-ng.git",
      "cd installer-ng ; git checkout ${local.installer_revision}",
      "cd",
      "sudo rm -rf /opt/scalr-server/embedded/cookbooks/scalr-server",
      "sudo cp -R installer-ng/files/scalr-server-cookbooks/scalr-server /opt/scalr-server/embedded/cookbooks/scalr-server",
      "sudo rm -rf installer-ng",
    ]
  }

  depends_on = [
    google_compute_instance.scalr_node,
    null_resource.install_scalr_server_package,
    null_resource.configure_scalr_server_package,
  ]
  triggers = {
    instance_id             = google_compute_instance.scalr_node.instance_id
    scalr_server_package_id = null_resource.install_scalr_server_package.id
    installer_revision      = var.installer_revision
  }
  count = (var.installer_revision == "" ? 0 : 1)
}

locals {
  fatmouse_requirements_path = "/opt/scalr-server/embedded/scalr/app/python/fatmouse/infra/requirements/server-devel.txt"
  fatmouse_site_packages     = "/opt/scalr-server/embedded/lib/python3.6/site-packages"
}
resource "null_resource" "update_fatmouse" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "sudo rm -rf fatmouse",
      "git clone https://${var.github_token}@github.com/Scalr/fatmouse.git",
      "cd fatmouse ; git checkout ${local.fatmouse_revision}",
      "cd",
      "sudo rm -rf /opt/scalr-server/embedded/scalr/app/python/fatmouse",
      "sudo mv fatmouse /opt/scalr-server/embedded/scalr/app/python/fatmouse",

      # Upgrade requirements
      "sudo /opt/scalr-server/embedded/bin/pip3 install --upgrade pip==19.0.3",
      "sudo rm -rf /tmp/requirements.txt",
      "sudo cp ${local.fatmouse_requirements_path} /tmp/requirements.txt",
      "sudo sed -i 's/git+git@github.com:Scalr/git+git:\\/\\/github.com\\/Scalr/g' /tmp/requirements.txt",
      "sudo sed -i 's/git+git:/git+https:/g' /tmp/requirements.txt",                                               # force HTTP to use proxy
      "sudo sed -i 's/https:\\/\\/github.com/https:\\/\\/${var.github_token}@github.com/g' /tmp/requirements.txt", # force Oauth2 token to access the Scalr repositories
      "sudo /opt/scalr-server/embedded/bin/pip3 install -U --upgrade-strategy=only-if-needed --exists-action=w --no-deps --src=${local.fatmouse_site_packages} -r /tmp/requirements.txt",
      "sudo rm -rf /tmp/requirements.txt",
    ]
  }

  depends_on = [
    null_resource.update_scalr_server_cookbook,
  ]
  triggers = {
    instance_id        = google_compute_instance.scalr_node.instance_id
    fatmouse_revision  = local.fatmouse_revision
    int_scalr_revision = local.int_scalr_revision
  }
  count = (var.fatmouse_revision == "" ? 0 : 1)
}

resource "null_resource" "reconfigure_scalr_server" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "sudo bash -c 'sudo scalr-server-ctl reconfigure || { cat /opt/scalr-server/var/log/installer/reconfigure.log && exit 1 ; }'",
    ]
  }

  depends_on = [
    google_compute_instance.scalr_node,
    null_resource.install_scalr_server_package,
    null_resource.update_scalr_server_cookbook,
    null_resource.update_fatmouse,
  ]
  triggers = {
    instance_id        = google_compute_instance.scalr_node.instance_id
    scalr_package_id   = null_resource.install_scalr_server_package.id
    environment_id     = null_resource.set_environment_variables.id,
    configuration_id   = null_resource.configure_scalr_server_package.id
    installer_revision = local.installer_revision
  }
}

# TODO: install requirements and build UI
resource "null_resource" "update_scalr" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",

      # Update scalr package
      "sudo rm -rf int-scalr",
      "sudo git clone https://${var.github_token}@github.com/Scalr/int-scalr.git",
      "cd int-scalr ; sudo git checkout ${local.int_scalr_revision}",
      "cd",
      "sudo rm -rf /opt/scalr-server/embedded/scalr/app/src/",
      "sudo mkdir -p /opt/scalr-server/embedded/scalr/app/src/",
      "sudo mv int-scalr/app/src/* /opt/scalr-server/embedded/scalr/app/src/",
      "sudo rm -rf int-scalr",

      # Upgrade scalr requirements
      # "cd /opt/scalr-server/embedded/scalr",
      # "sudo /opt/scalr-server/embedded/bin/php /opt/scalr-server/embedded/bin/composer.phar install --no-progress",

      # Build UI
      # see: https://github.com/nodejs/node/issues/32107
      # "sudo rm -rf /opt/scalr-server/embedded/scalr/package-lock.json",
      # "sudo rm -rf /opt/scalr-server/embedded/scalr/node_modules",
      # "cd /opt/scalr-server/embedded/scalr/ui",
      # "sudo npm install",
      # "sudo npm run build:development",
    ]
  }

  depends_on = [
    null_resource.install_scalr_server_package,
    null_resource.reconfigure_scalr_server,
  ]
  triggers = {
    instance_id    = google_compute_instance.scalr_node.instance_id
    scalr_revision = local.int_scalr_revision
  }
  count = (var.int_scalr_revision == "" ? 0 : 1)
}
