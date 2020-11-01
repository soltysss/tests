output "installation_id" {
  value = module.drone-gcp.installation_id
}

output "hostname" {
  value = module.drone-gcp.hostname
}

output "server_public_ip" {
  value = module.drone-gcp.server_public_ip
}

output "ssh_user" {
  value = module.drone-gcp.ssh_user
}

output "ssh_private_key" {
  value     = module.drone-gcp.ssh_private_key
  sensitive = true
}

output "sql_database_password" {
  value     = module.drone-gcp.sql_database_password
  sensitive = true
}

output "drone_primary_admin_token" {
  value     = module.drone-gcp.drone_primary_admin_token
  sensitive = true
}
