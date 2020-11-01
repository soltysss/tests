provider "google" {
  zone = var.zone
}

resource "random_id" "scalr_id" {
  byte_length = 4
}

locals {
  scalr_id                = random_id.scalr_id.hex
  scalr_node_firewall_tag = "scalr-${random_id.scalr_id.hex}-node"
  scalr_hostname          = "${random_id.scalr_id.hex}.devel.scalr.com"
  subnet_mask             = "10.10.10.0/24"
}

module "scalr_node" {
  source = "../../modules/scalr_node"

  # Instance settings
  scalr_id     = local.scalr_id
  zone         = var.zone
  machine_type = var.scalr_machine_type
  owner        = var.owner

  # Networking settings
  subnetwork_self_link = google_compute_subnetwork.scalr_subnetwork.self_link
  hostname             = local.scalr_hostname
  extra_tags           = [local.scalr_node_firewall_tag]

  # Scalr package settings
  scalr_package_name = var.scalr_package_name
  packagecloud_token = var.packagecloud_token
  github_token       = var.github_token
  installer_revision = var.installer_revision
  fatmouse_revision  = var.fatmouse_revision
  int_scalr_revision = var.int_scalr_revision

  node_depends_on = [
    local.firewall_rules
  ]
}
