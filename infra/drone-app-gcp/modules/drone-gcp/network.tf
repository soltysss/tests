data "google_compute_network" "drone_network" {
  name = var.vpc_network_name
}

resource "google_compute_subnetwork" "drone_subnetwork" {
  name          = "drone-${local.installation_id}-network-${var.region}"
  region        = var.region
  ip_cidr_range = var.subnetwork_ip_range
  network       = data.google_compute_network.drone_network.self_link
}

resource "google_compute_firewall" "block_incoming_connections" {
  name        = "drone-${local.installation_id}-block-incoming-connections"
  network     = data.google_compute_network.drone_network.self_link
  description = "Block all incoming connections to the VPC network"
  direction   = "INGRESS"
  priority    = 1000

  target_tags = [local.drone_node_firewall_tag]

  deny {
    protocol = "icmp"
  }
  deny {
    protocol = "tcp"
  }
  deny {
    protocol = "udp"
  }
}

resource "google_compute_firewall" "allow_incoming_https" {
  name        = "drone-${local.installation_id}-allow-incoming-https"
  network     = data.google_compute_network.drone_network.self_link
  description = "Allow incoming HTTPS connections to the Drone"
  direction   = "INGRESS"
  priority    = 999

  target_tags = [local.drone_node_firewall_tag]

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }
}

resource "google_compute_firewall" "allow_incoming_http" {
  name        = "drone-${local.installation_id}-allow-incoming-http"
  network     = data.google_compute_network.drone_network.self_link
  description = "Allow incoming HTTP connections to the Drone"
  direction   = "INGRESS"
  priority    = 999

  target_tags = [local.drone_node_firewall_tag]
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
}


resource "google_compute_firewall" "allow_incoming_ssh" {
  name        = "drone-${local.installation_id}-allow-incoming-ssh"
  network     = data.google_compute_network.drone_network.self_link
  description = "Allow incoming SSH connections to the Drone"
  direction   = "INGRESS"
  priority    = 999

  target_tags = [local.drone_node_firewall_tag]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
}
