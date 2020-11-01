#
# Scalr outputs
#

output "scalr_id" {
  value = local.scalr_id
}

output "public_ip" {
  value = module.scalr_node.public_ip
}

output "private_hostname" {
  value = "https://${local.scalr_hostname}"
}

output "admin_password" {
  value       = module.scalr_node.admin_password
  description = "The Scalr admin password"
  sensitive   = true
}

output "ssh_user" {
  value       = module.scalr_node.ssh_user
  description = "The SSH user of the Scalr node"
}

output "ssh_port" {
  value       = module.scalr_node.ssh_port
  description = "The SSH port of the Scalr node"
}

output "base_64_ssh_private_key" {
  value       = base64encode(module.scalr_node.ssh_private_key)
  description = "The private SSH key to the Scalr node (base64 encoded)"
  sensitive   = true
}

output "oneliner_add_ssh_key" {
  value       = "echo ${base64encode(module.scalr_node.ssh_private_key)} | base64 --decode > ~/.ssh/scalr-${local.scalr_id} ; chmod 400 ~/.ssh/scalr-${local.scalr_id}"
  description = "Oneliner to install the Scalr node SSH key"
  sensitive   = true
}

output "oneliner_ssh_to_scalr" {
  value       = "ssh -i ~/.ssh/scalr-${local.scalr_id} ${module.scalr_node.ssh_user}@${module.scalr_node.public_ip} -p ${module.scalr_node.ssh_port}"
  description = "Oneliner to SSH to the Scalr node"
  sensitive   = true
}

output "oneliner_add_hosts_record" {
  value       = "sudo bash -c 'echo \"${module.scalr_node.public_ip} ${local.scalr_hostname}\" >> /etc/hosts'"
  description = "Oneliner to add the Scalr node alias to the local machine"
}

output "base_64_ssl_extra_ca_file" {
  value       = base64encode(module.scalr_node.ssl_extra_ca_file)
  description = "The Scalr node CA bundle (base64 encoded)"
  sensitive   = true
}

#
# Proxy outputs
#

output "http_proxy" {
  value       = module.proxy_node.http_proxy
  description = "The HTTP proxy URL"
  sensitive   = true
}

