provider "google" {
  zone = var.zone
}
provider "null" {}

resource "random_id" "scalr_id" {
  byte_length = 4
}

locals {
  scalr_id      = random_id.scalr_id.hex
  base_hostname = "devel.scalr.com"
  subnet_mask   = "10.10.10.0/24"
}

locals {
  scalr_node_firewall_tag  = "scalr-${local.scalr_id}-node"
  scalr_proxy_firewall_tag = "scalr-${local.scalr_id}-proxy"
  scalr_hostname           = "${local.scalr_id}.${local.base_hostname}"
  proxy_hostname           = "${local.scalr_id}.proxy.${local.base_hostname}"
}

module "proxy_node" {
  source               = "../../modules/proxy_node"
  machine_type         = var.proxy_machine_type
  zone                 = var.zone
  subnetwork_self_link = google_compute_subnetwork.scalr_subnetwork.self_link
  scalr_id             = local.scalr_id
  extra_tags           = [local.scalr_proxy_firewall_tag]
  owner                = var.owner
  hostname             = local.proxy_hostname

  node_depends_on = [
    local.firewall_rules,
  ]
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
  extra_tags           = [local.scalr_node_firewall_tag]
  hostname             = local.scalr_hostname
  http_proxy           = module.proxy_node.http_proxy

  # Scalr package settings
  scalr_package_name = var.scalr_package_name
  packagecloud_token = var.packagecloud_token
  github_token       = var.github_token
  installer_revision = var.installer_revision
  fatmouse_revision  = var.fatmouse_revision
  int_scalr_revision = var.int_scalr_revision

  node_depends_on = [
    local.firewall_rules,
  ]
}
