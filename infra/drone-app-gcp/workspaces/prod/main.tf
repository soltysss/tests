data "terraform_remote_state" "shared_gke" {
  backend = "remote"

  config = {
    hostname     = "my.scalr.com"
    organization = var.shared_gke_organization
    workspaces = {
      name = var.shared_gke_workspace
    }
  }
}

module "drone-gcp" {
  source = "../../modules/drone-gcp"

  project                        = var.project
  region                         = var.region
  zone                           = var.zone
  hostname                       = var.hostname
  subnetwork_ip_range            = var.subnetwork_ip_range
  server_machine_type            = var.server_machine_type
  server_service_account_id      = var.server_service_account_id
  agent_machine_type             = var.agent_machine_type
  agent_service_account_id       = var.agent_service_account_id
  gcs_bucket_folder_with_secrets = var.gcs_bucket_folder_with_secrets
  vpc_network_name               = data.terraform_remote_state.shared_gke.outputs.vpc_network
  dns_zone_name                  = var.dns_zone_name
  drone_github_client_id         = var.drone_github_client_id
  drone_github_client_secret     = var.drone_github_client_secret
  drone_primary_admin            = var.drone_primary_admin
  drone_server_version           = var.drone_server_version
  drone_cli_version              = var.drone_cli_version
  drone_email_host               = var.drone_email_host
  drone_email_port               = var.drone_email_port
  drone_email_password           = var.drone_email_password
  drone_email_username           = var.drone_email_username
  github_organization            = var.github_organization
  cloudsql_instance_name         = data.terraform_remote_state.shared_gke.outputs.database_instance_name
  cloudsql_private_ip            = data.terraform_remote_state.shared_gke.outputs.cloudsql_private_ip
  cloudsql_database_name         = var.cloudsql_database_name
  cloudsql_database_user         = var.cloudsql_database_user
  working_hours                  = var.working_hours
  working_hours_min_replicas     = var.working_hours_min_replicas
  autoscaling_max_replicas       = var.autoscaling_max_replicas
  autoscaling_min_replicas       = var.autoscaling_min_replicas
  autoscaling_cooldown_period    = var.autoscaling_cooldown_period
  autoscaling_cpu_utilization    = var.autoscaling_cpu_utilization
  runner_capacity                = var.runner_capacity
}
