output installation_id {
  description = "Drone installation ID. This is required to monitor installation resources."
  value       = local.installation_id
}

output hostname {
  description = "Drone Server hostname."
  value       = local.hostname
}

output server_public_ip {
  description = "The public IP address of the Drone Server"
  value       = local.public_ip
}

output ssh_user {
  description = "The private SSH key to all Drone instances."
  value       = local.ssh_user
}

output "ssh_private_key" {
  description = "The private SSH key to all Drone instances."
  value       = local.ssh_private_key
  sensitive   = true
}

output "sql_database_password" {
  description = "The password to Cloud SQL Drone database."
  value       = google_sql_user.default.password
  sensitive   = true
}

output "drone_primary_admin_token" {
  description = "Drone primary admin token for using in Drone CLI."
  value       = local.drone_primary_admin_token
  sensitive   = true
}
