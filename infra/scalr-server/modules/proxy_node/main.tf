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

resource "google_compute_address" "proxy_node_address" {
  name = "scalr-${var.scalr_id}-proxy-node-${var.index}-address"
}

resource "google_compute_instance" "proxy_node" {
  name         = "scalr-${var.scalr_id}-proxy-node-${var.index}"
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
      nat_ip = google_compute_address.proxy_node_address.address
    }
  }
  hostname                  = var.hostname
  tags                      = var.extra_tags
  allow_stopping_for_update = true
  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_public_key}"
  }
  labels = {
        owner    = var.owner
  }
  depends_on = [
    var.node_depends_on
  ]
}

resource "random_password" "squid_password" {
  length  = 24
  special = false
}

locals {
  public_ip      = google_compute_address.proxy_node_address.address
  squid_user     = "squid-user"
  squid_port     = 3128
  squid_password = random_password.squid_password.result
}

output "proxy_port" {
  value       = local.squid_port
  description = "The port of the proxy server"

  depends_on = [
    null_resource.configure_squid_server
  ]
}

output "proxy_user" {
  value       = local.squid_user
  description = "The user of the proxy server"

  depends_on = [
    null_resource.configure_squid_server
  ]
}

output "proxy_password" {
  value       = local.squid_password
  description = "Password of the user of the proxy server"
  sensitive   = true

  depends_on = [
    null_resource.configure_squid_server
  ]
}

output "private_ip" {
  value       = google_compute_instance.proxy_node.network_interface[0].network_ip
  description = "The private IP address of the proxy server"
}

output "public_ip" {
  value       = local.public_ip
  description = "The public IP address of the proxy server"
}

output "http_proxy" {
  value       = "http://${local.squid_user}:${local.squid_password}@${var.hostname}:${local.squid_port}"
  description = "The proxy URL"
  sensitive   = true

  depends_on = [
    null_resource.configure_squid_server
  ]
}

output "ssh_user" {
  value       = local.ssh_user
  description = "The SSH user"

  depends_on = [
    google_compute_instance.proxy_node
  ]
}

output "ssh_port" {
  value       = local.ssh_port
  description = "The SSH port"

  depends_on = [
    google_compute_instance.proxy_node
  ]
}

output "ssh_private_key" {
  value       = local.ssh_private_key
  description = "The private SSH key to the node"
  sensitive   = true
}
