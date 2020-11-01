provider "google" {
  region  = var.region
  project = var.project
  zone    = var.zone
}

resource "random_id" "installation_id" {
  byte_length = 4
}

resource "random_id" "drone_rpc_secret" {
  byte_length = 16
}

resource "random_id" "drone_primary_admin_token" {
  byte_length = 16
}

resource "tls_private_key" "drone" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

locals {
  installation_id           = random_id.installation_id.hex
  ssh_user                  = "drone"
  ssh_port                  = 22
  ssh_private_key           = tls_private_key.drone.private_key_pem
  ssh_public_key            = tls_private_key.drone.public_key_openssh
  drone_node_firewall_tag   = "drone-node"
  drone_primary_admin_token = random_id.drone_primary_admin_token.hex
  drone_primary_admin       = "username:${var.drone_primary_admin},machine:false,admin:true,token:${local.drone_primary_admin_token}"
  drone_rpc_secret          = random_id.drone_rpc_secret.hex
  agents_group_manager_name = "drone-${local.installation_id}-agents-igm"
}

data "google_compute_image" "ubuntu_1804" {
  family  = "ubuntu-1804-lts"
  project = "ubuntu-os-cloud"
}
