resource "google_dns_managed_zone" "scalr_dns_zone" {
  name       = "scalr-${local.scalr_id}-zone"
  dns_name   = "${local.base_hostname}."
  visibility = "private"
  private_visibility_config {
    networks {
      network_url = google_compute_network.scalr_network.self_link
    }
  }
}

resource "google_dns_record_set" "scalr_node_dns_record" {
  name         = "${local.scalr_hostname}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.scalr_dns_zone.name
  rrdatas      = [module.scalr_node.private_ip]
}

resource "google_dns_record_set" "proxy_node_dns_record" {
  name         = "${local.proxy_hostname}."
  type         = "A"
  ttl          = 300
  managed_zone = google_dns_managed_zone.scalr_dns_zone.name
  rrdatas      = [module.proxy_node.private_ip]
}
