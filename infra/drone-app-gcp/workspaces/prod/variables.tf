variable shared_gke_organization {
  description = "Organization where Shared GKE Cluster are deployed"
  type        = string
}

variable shared_gke_workspace {
  description = "Workspace where Shared GKE Cluster are deployed"
  type        = string
  default     = "shared-gke-prod"
}

variable project {
  description = "GCP Project for installation."
  type        = string
  default     = "production-244305"
}

variable region {
  description = <<EOT
  GCP region of installation.
  The region should be as close as possible to the development team.
  EOT
  type        = string
  default     = "europe-west1"
}

variable zone {
  description = "GCP zone of installation."
  type        = string
  default     = "europe-west1-b"
}

variable compute_extra_labels {
  description = <<EOT
  We have cleanup cloud resource mechanism and if you want your resources 
  not to be removed you need to define a label with key `owner` and your nickname as value,
  It is relevant  only to `dev` workspace.
  EOT
  type        = map
  default     = {}
}

variable server_machine_type {
  description = <<EOT
  The machine type of the Drone Server node.
  Server machine not need to be powerful because it only manages a queue.
  All pipeliners are running on the Agents.
  EOT
  type        = string
  default     = "n1-standard-1"
}

variable server_service_account_id {
  description = <<EOT
  Drone Server Service Account.
  The Service account id.
  This is the part of the service account's email field that comes before the @ symbol.
  EOT
  type        = string
  default     = "drone-server"
}

variable agent_machine_type {
  description = <<EOT
  The machine type of the Drone Agent node.
  Agent machine must be powerful (more than the default) 
  because the pipelines run on this machine.
  EOT
  type        = string
  default     = "n1-standard-1"
}

variable agent_service_account_id {
  description = <<EOT
  Drone Agents Service Account.
  The Service account id.
  This is the part of the service account's email field that comes before the @ symbol.
  EOT
  type        = string
  default     = "drone-agent"
}

variable subnetwork_ip_range {
  description = <<EOT
  IP range for subnetwork.
  Due to a lot of different subnets in a default VPC network Drone specified unique ip_range.
  EOT
  type        = string
  default     = "10.25.10.0/24"
}

variable gcs_bucket_folder_with_secrets {
  description = <<EOT
  The GCS Bucker folder where the secrets are  stored.
  Agent pull this secrets and use in pipelines.
  EOT
  type        = string
}

# DNS
variable dns_zone_name {
  description = <<EOT
  IP range for subnetwork.
  Due to a lot of different subnets in a default VPC network Drone specified unique ip_range.
  EOT
  type        = string
  default     = "scalr-labs-net"
}

variable hostname {
  description = <<EOT
  Drone endpoint will be ath ttps://[hostname].scalr-labs.net.
  Be careful about frequent server deployment.
  You can get a limit of a registration SSL certificate for that hostname.
  EOT
  type        = string
  default     = "drone"
}

# Provisioning Drone

variable drone_server_version {
  description = "Drone Server version."
  type        = string
  default     = "1.9.0"
}
variable drone_runner_version {
  description = "Drone Runner version."
  type        = string
  default     = "1.5.0"
}

variable drone_github_client_id {
  description = "Value configures the GitHub OAuth client id."
  type        = string
}

variable drone_github_client_secret {
  description = "Value configures the GitHub oauth client secret."
  type        = string
}

variable drone_primary_admin {
  description = <<EOT
  When you configure the Drone server you can create the initial administrative account
  by passing the below environment variable, which defines the account username (e.g. github handle).
  EOT
  type        = string
}

variable drone_cli_version {
  description = "Drone CLI version."
  type        = string
  default     = "1.2.1"
}

variable drone_email_host {
  description = "SMTP server host."
  type        = string
}

variable drone_email_port {
  description = "SMTP server port, defaults to 587."
  type        = number
  default     = 587
}

variable drone_email_username {
  description = "SMTP username."
  type        = string
}

variable drone_email_password {
  description = "SMTP password."
  type        = string
}

variable "github_organization" {
  description = "GitHub Organization name."
  type        = string
  default     = "Scalr"
}

# CloudSQL

variable cloudsql_database_name {
  description = "The name of CloudSQL instance where to create Drone database and user."
  type        = string
  default     = "drone"
}

variable cloudsql_database_user {
  description = "CloudSQL private IP to connect."
  type        = string
  default     = "drone"
}

# Autoscaling Drone Agents

variable autoscaling_max_replicas {
  description = "Autoscaling, max replicas."
  type        = number
  default     = 5
}

variable autoscaling_min_replicas {
  description = "Autoscaling, min replics."
  type        = number
  default     = 1
}

variable autoscaling_cooldown_period {
  description = <<EOT
  Autoscaling, cooldown period in seconds.
  EOT
  type        = number
  default     = 200
}

variable autoscaling_cpu_utilization {
  description = <<EOT
  Autoscaling, cpu utilization policy."
  EOT
  type        = number
  default     = 0.8
}

variable working_hours {
  description = <<EOT
  Possibility to define working hours in the format: <start>-<end>. 
  Example: 09-20, Means workday starts in 09 and finish in 20.
  EOT
  type        = string
  default     = "09-20"
}

variable working_hours_min_replicas {
  description = <<EOT
  Autoscaling, min replics in working hours.
  This value must be less than the value of autoscaling_max_replicas.
  EOT
  type        = number
  default     = 2
}

# Provisioning Linux Agent

variable runner_capacity {
  description = "Limits the number of concurrent pipelines that a runner can execute."
  type        = number
  default     = 5
}
