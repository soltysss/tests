output "cluster_endpoint" {
  value = google_container_cluster.default.endpoint
}

output "cluster_ca_certificate" {
  value = google_container_cluster.default.master_auth.0.cluster_ca_certificate
}

output "cluster_client_certificate" {
  value = google_container_cluster.default.master_auth.0.client_certificate
}

output "cluster_client_key" {
  value = google_container_cluster.default.master_auth.0.client_key
}

output "cluster_name" {
  value = google_container_cluster.default.name
}

output "kubectl_context" {
  value = "gke_${google_container_cluster.default.project}_${google_container_cluster.default.location}_${google_container_cluster.default.name}"
}

output "cloudsql_private_ip" {
  value = google_sql_database_instance.shared.private_ip_address
}

output "database_instance_name" {
  value = var.database_instance_name
}

output "vpc_network" {
  value = google_compute_network.default.name
}

output "ingress_public_ip" {
  value       = local.ingress_public_ip
  description = "Load Balancer IPv4 address"
}
