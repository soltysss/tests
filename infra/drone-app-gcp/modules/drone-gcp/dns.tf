data "google_dns_managed_zone" "drone_dns_zone" {
  name    = var.dns_zone_name
  project = "production-244305"
}

locals {
  hostname = trimsuffix("${var.hostname}.${data.google_dns_managed_zone.drone_dns_zone.dns_name}", ".")
}

resource "google_dns_record_set" "drone_dns_record" {
  name         = "${var.hostname}.${data.google_dns_managed_zone.drone_dns_zone.dns_name}"
  type         = "A"
  ttl          = 300
  managed_zone = data.google_dns_managed_zone.drone_dns_zone.name
  rrdatas      = ["${google_compute_instance.server.network_interface[0].access_config[0].nat_ip}"]
  project      = "production-244305"
}
