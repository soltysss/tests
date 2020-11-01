locals {
  public_ip     = google_compute_address.server.address
  working_hours = split("-", var.working_hours)
}

resource "google_compute_address" "server" {
  name = "drone-${local.installation_id}-server-address"
}

data "google_service_account" "server" {
  account_id = var.server_service_account_id
  project    = var.project
}

resource "google_compute_instance" "server" {
  name         = "drone-${local.installation_id}-server"
  machine_type = var.server_machine_type
  zone         = var.zone

  metadata = {
    ssh-keys = "${local.ssh_user}:${local.ssh_public_key}"
  }

  labels = var.compute_extra_labels
  tags   = [local.drone_node_firewall_tag]

  network_interface {
    subnetwork = google_compute_subnetwork.drone_subnetwork.self_link
    access_config {
      nat_ip = local.public_ip
    }
  }

  boot_disk {
    initialize_params {
      image = data.google_compute_image.ubuntu_1804.self_link
    }
  }

  service_account {
    email  = data.google_service_account.server.email
    scopes = ["cloud-platform"]
  }

  metadata_startup_script = templatefile("${path.module}/scripts/server_startup.sh.tmpl", {
    service_acc_id                                      = data.google_service_account.server.unique_id
    google_sql_user_name                                = google_sql_user.default.name
    google_sql_user_password                            = google_sql_user.default.password
    drone_rpc_secret                                    = local.drone_rpc_secret
    drone_server_host                                   = local.hostname
    drone_primary_admin                                 = local.drone_primary_admin
    drone_primary_admin_token                           = local.drone_primary_admin_token
    cloudsql_private_ip                                 = var.cloudsql_private_ip
    cloudsql_database_name                              = var.cloudsql_database_name
    drone_github_client_id                              = var.drone_github_client_id
    drone_github_client_secret                          = var.drone_github_client_secret
    drone_cli_version                                   = var.drone_cli_version
    drone_server_version                                = var.drone_server_version
    email_host                                          = var.drone_email_host
    email_port                                          = var.drone_email_port
    email_username                                      = var.drone_email_username
    email_password                                      = var.drone_email_password
    github_organization                                 = var.github_organization
    agents_instance_group_name                          = local.agents_group_manager_name
    agents_instance_group_zone                          = var.zone
    agents_instance_group_min_replicas_in_working_hours = var.working_hours_min_replicas
    agents_instance_group_min_replicas                  = var.autoscaling_min_replicas
    agents_instance_group_max_replicas                  = var.autoscaling_max_replicas
    working_hours_start                                 = element(local.working_hours, 0)
    working_hours_end                                   = element(local.working_hours, 1)
  })
}
