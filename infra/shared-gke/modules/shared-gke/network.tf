locals {
  network_name = var.network_name == "" || var.network_name == null ? "gke-network-${local.id}" : var.network_name
}

resource "google_compute_network" "default" {
  name                    = local.network_name
  auto_create_subnetworks = false
  provider                = google-beta
}

resource "google_compute_subnetwork" "regional" {
  name          = "${local.network_name}-${var.region}"
  region        = var.region
  ip_cidr_range = "10.20.0.0/16"
  network       = google_compute_network.default.name
}

resource "google_compute_global_address" "mysql_ip" {
  provider      = google-beta
  name          = "${var.database_instance_name}-private-ip"
  purpose       = "VPC_PEERING"
  prefix_length = 16
  address_type  = "INTERNAL"
  network       = google_compute_network.default.self_link
}

resource "google_service_networking_connection" "mysql_private" {
  provider                = google-beta
  network                 = google_compute_network.default.self_link
  service                 = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.mysql_ip.name]
}
