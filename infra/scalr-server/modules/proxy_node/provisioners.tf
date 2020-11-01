locals {
  passwords_path = "/etc/squid/passwords"
}

data "template_file" "squid_config_template" {
  template = file("${path.module}/configs/squid.conf.tpl")

  vars = {
    passwords_path = local.passwords_path
    http_port      = local.squid_port
  }
}

resource "null_resource" "install_squid_server" {
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
      "sudo yum -y install squid httpd-tools telnet git",
      "sudo chown -R ${local.ssh_user} /etc/squid/",
      "sudo systemctl disable squid",
      "sudo systemctl stop squid",
    ]
  }

  depends_on = [
    google_compute_instance.proxy_node,
  ]
  triggers = {
    instance_id = google_compute_instance.proxy_node.instance_id
    ssh_user = local.ssh_user
  }
}

resource "null_resource" "configure_squid_server" {
  connection {
    host        = local.public_ip
    type        = "ssh"
    user        = local.ssh_user
    timeout     = local.ssh_timeout
    private_key = local.ssh_private_key
  }

  provisioner "file" {
    content     = data.template_file.squid_config_template.rendered
    destination = "/etc/squid/squid.conf"
  }

  provisioner "remote-exec" {
    inline = [
      "set -ex",
      "sudo systemctl stop squid",
      "sudo rm -rf ${local.passwords_path}",
      "htpasswd -b -c ${local.passwords_path} ${local.squid_user} ${local.squid_password}",
      "sudo systemctl start squid",
    ]
  }

  depends_on = [
    google_compute_instance.proxy_node,
    null_resource.install_squid_server
  ]
  triggers = {
    instance_id = google_compute_instance.proxy_node.instance_id
    passwords_path = local.passwords_path
    squid_user     = local.squid_user
    squid_password = local.squid_password
    ssh_user       = local.ssh_user
    squid_config   = data.template_file.squid_config_template.rendered
  }
}
