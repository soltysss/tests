

variable "hostname" {
  description = "Your drone endpoint will be at https://[hostname].scalr-labs.net"
  default     = "drone-devel"
}

variable "k8s_cluster_context" {
  description = "Kubernetes Cluster Context to operation in"
}

variable "cloudsql_instance_name" {
  description = "The name of CloudSQL instance where to create Drone database and user"
}

variable "cloudsql_private_ip" {
  description = "The CloudSQL private IP to connect from GKE"
}

variable "cloudsql_database_name" {
  default = "drone-devel"
}

variable "cloudsql_database_user" {
  default = "drone-devel"
}

variable "drone_github_client_id" {
  description = "A string containing your GitHub OAuth Client ID"
}

variable "drone_github_client_secret" {
  description = "A string containing your GitHub OAuth Client Secret"
}

variable "drone_rpc_secret" {
  description = "Shared secret to authenticate communication between Pipeline controllers and your central Drone server"
  default     = "d3fc6850608f61cd14e525f29649ea85"
}

variable "drone_k8s_namespace" {
  default = "drone"
}

variable "project" {
  default = "development-156220" # ?
}

variable "region" {
  default = "us-west1"
}

variable "credentials" {
  description = "Path to or the contents of a service account key file in JSON format"
}
