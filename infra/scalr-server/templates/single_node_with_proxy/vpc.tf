data "google_project" "project" {}

resource "google_compute_network" "scalr_network" {
  name                    = "scalr-${local.scalr_id}-network"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "scalr_subnetwork" {
  name          = "scalr-${local.scalr_id}-network-${var.region}"
  ip_cidr_range = local.subnet_mask
  region        = var.region
  network       = google_compute_network.scalr_network.self_link
}

resource "google_compute_firewall" "block_incoming_connections" {
  name        = "scalr-${local.scalr_id}-block-incoming-connections"
  network     = google_compute_network.scalr_network.self_link
  description = "Block all incoming connections to the VPC network"
  direction   = "INGRESS"
  priority    = 1000

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
  name        = "scalr-${local.scalr_id}-allow-incoming-https"
  network     = google_compute_network.scalr_network.self_link
  description = "Allow incoming HTTPS connections to the Scalr node"
  priority    = 999

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags = [local.scalr_node_firewall_tag]
}

resource "google_compute_firewall" "allow_incoming_proxy" {
  name        = "scalr-${local.scalr_id}-allow-incoming-proxy"
  network     = google_compute_network.scalr_network.self_link
  description = "Allow incoming connections to the proxy server"
  priority    = 999

  allow {
    protocol = "tcp"
    ports    = ["3128"]
  }

  target_tags = [local.scalr_proxy_firewall_tag]
}

resource "google_compute_firewall" "allow_incoming_ssh" {
  name        = "scalr-${local.scalr_id}-allow-incoming-ssh"
  network     = google_compute_network.scalr_network.self_link
  description = "Allow incoming SSH connections to the Scalr node and proxy server"
  priority    = 999

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }
  target_tags = [local.scalr_proxy_firewall_tag, local.scalr_node_firewall_tag]
}

resource "google_compute_firewall" "block_outgoing_connections" {
  name        = "scalr-${local.scalr_id}-block-outgoing-connections"
  network     = google_compute_network.scalr_network.self_link
  description = "Block all outgoing connections from the VPC network"
  direction   = "EGRESS"

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

resource "google_compute_firewall" "allow_outgoing_from_proxy_node" {
  name        = "scalr-${local.scalr_id}-allow-outgoing-from-proxy-node"
  network     = google_compute_network.scalr_network.self_link
  description = "Allow outgoing connections from the proxy node"
  direction   = "EGRESS"
  priority    = 999

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }

  target_tags        = [local.scalr_proxy_firewall_tag]
  destination_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_outgoing_to_internal_nodes" {
  name        = "scalr-${local.scalr_id}-allow-outgoing-to-internal-nodes"
  network     = google_compute_network.scalr_network.self_link
  description = "Allow outgoing connections within the VPC"
  direction   = "EGRESS"
  priority    = 999

  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }

  destination_ranges = [local.subnet_mask]
}

locals {
  firewall_rules = [
    google_compute_firewall.block_incoming_connections,
    google_compute_firewall.allow_incoming_ssh,
    google_compute_firewall.allow_incoming_https,
    google_compute_firewall.allow_incoming_proxy,
    google_compute_firewall.block_outgoing_connections,
    google_compute_firewall.allow_outgoing_from_proxy_node,
    google_compute_firewall.allow_outgoing_to_internal_nodes,
  ]
}
