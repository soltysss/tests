variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "cluster_name" {
  default = "shared-gke-dev"
}

variable "database_instance_name" {
  default = "shared-mysql-dev"
}

variable "database_instance_type" {
  description = "The CloudSQL instance type (Second Generation)"
  default     = "db-f1-micro"
}

variable "network_name" {
  description = "The name of the VPC"
  default     = ""
}

variable "max_node_count" {
  description = "Maximum number of Cluster nodes in the NodePool. Must be >= 1"
  default     = 1
}

variable "node_instance_type" {
  description = "Instance type for cluster nodes"
  default     = "n1-standard-1"
}

variable "min_master_version" {
  description = "The Kubernetes version of the masters. If set to 'latest' it will pull latest available version in the selected region. Details: https://cloud.google.com/kubernetes-engine/versioning-and-upgrades#specifying_cluster_version"
  default     = "1.16"
}
