output "cluster_endpoint" {
  value = module.shared-gke.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.shared-gke.cluster_ca_certificate
}

output "cluster_client_certificate" {
  value = module.shared-gke.cluster_client_certificate
}

output "cluster_client_key" {
  value = module.shared-gke.cluster_client_key
}

output "cluster_name" {
  value = module.shared-gke.cluster_name
}

output "kubectl_context" {
  value = module.shared-gke.kubectl_context
}

output "cloudsql_private_ip" {
  value = module.shared-gke.cloudsql_private_ip
}

output "database_instance_name" {
  value = var.database_instance_name
}

output "vpc_network" {
  value = module.shared-gke.vpc_network
}

output "ingress_public_ip" {
  value       = module.shared-gke.ingress_public_ip
  description = "Load Balancer IPv4 address"
}
