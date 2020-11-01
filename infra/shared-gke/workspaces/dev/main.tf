/**
 * # Development GKE cluster
 */

provider "google" {
  region  = var.region
  zone    = var.zone
  version = "~> 3.39.0"
}

provider "google-beta" {
  region  = var.region
  zone    = var.zone
  version = "~> 3.39.0"
}

module "shared-gke" {
  source                 = "../../modules/shared-gke"
  cluster_name           = var.cluster_name
  database_instance_name = var.database_instance_name
  database_instance_type = var.database_instance_type
  max_node_count         = var.max_node_count
  node_instance_type     = var.node_instance_type
  region                 = var.region
  zone                   = var.zone
  min_master_version     = var.min_master_version
  network_name           = var.network_name
}
