resource "tls_private_key" "ssh" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

locals {
  ssh_user        = "gce-scalr-user"
  ssh_port        = 22
  ssh_timeout     = "300s"
  ssh_private_key = tls_private_key.ssh.private_key_pem
  ssh_public_key  = tls_private_key.ssh.public_key_openssh
}

resource "google_compute_address" "scalr_node_address" {
  name = "scalr-${var.scalr_id}-node-${var.index}-address"
}

resource "google_compute_instance" "scalr_node" {
  name         = "scalr-${var.scalr_id}-node-${var.index}"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "centos-7"
    }
  }
  network_interface {
    subnetwork = var.subnetwork_self_link
    access_config {
      nat_ip = google_compute_address.scalr_node_address.address
    }
  }
  hostname = var.hostname

  tags = var.extra_tags
  service_account {
    scopes = ["compute-rw"]
  }
  allow_stopping_for_update = true

  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_public_key}"
  }
  labels = {
    owner = var.owner
  }
  depends_on = [
    var.node_depends_on
  ]
}

locals {
  public_ip = google_compute_address.scalr_node_address.address
}

output "public_ip" {
  value       = local.public_ip
  description = "The public IP address of the scalr node"
}

output "private_ip" {
  value       = google_compute_instance.scalr_node.network_interface[0].network_ip
  description = "The private IP address of the scalr node"
}

output "ssh_user" {
  value       = local.ssh_user
  description = "The SSH user"

  depends_on = [
    google_compute_instance.scalr_node
  ]
}

output "ssh_port" {
  value       = local.ssh_port
  description = "The SSH port"

  depends_on = [
    google_compute_instance.scalr_node
  ]
}

output "ssh_private_key" {
  value       = local.ssh_private_key
  description = "The private SSH key to the node"
  sensitive   = true
}

output "admin_password" {
  value       = local.admin_password
  description = "The Scalr admin password"
  sensitive   = true
}

output "ssl_extra_ca_file" {
  value       = file("${local.scalr_certs_dir}/rootCA.pem")
  description = "The Scalr node CA bundle"
  sensitive   = true
}
