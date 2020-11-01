resource "google_container_cluster" "default" {
  name     = var.cluster_name
  location = var.zone

  network    = google_compute_network.default.self_link
  subnetwork = google_compute_subnetwork.regional.self_link

  initial_node_count       = 1
  remove_default_node_pool = true
  enable_kubernetes_alpha  = false
  enable_legacy_abac       = true
  min_master_version       = var.min_master_version

  maintenance_policy {
    daily_maintenance_window {
      start_time = "03:00"
    }
  }

  ip_allocation_policy {
    services_ipv4_cidr_block = "10.10.0.0/16"
    cluster_ipv4_cidr_block  = "10.15.0.0/16"
  }

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = true
    }
  }
}

resource "google_container_node_pool" "gke" {
  name     = "gke-${var.cluster_name}-pool"
  location = var.zone
  cluster  = google_container_cluster.default.name

  initial_node_count = 1
  autoscaling {
    min_node_count = var.min_node_count
    max_node_count = var.max_node_count
  }

  management {
    auto_repair  = false
    auto_upgrade = false
  }

  node_config {
    preemptible  = false
    machine_type = var.node_instance_type

    oauth_scopes = [
      "https://www.googleapis.com/auth/devstorage.read_write",
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
      "https://www.googleapis.com/auth/compute"

    ]

    metadata = {
      disable-legacy-endpoints = "true"
    }
  }

  lifecycle {
    ignore_changes = [
      initial_node_count,
    ]
  }
  depends_on = [
    google_container_cluster.default,
  ]
}
