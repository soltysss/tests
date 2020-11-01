
data "google_dns_managed_zone" "default" {
  name    = "scalr-labs-net"
  project = "production-244305" # ?
}

locals {
  drone_server_host = "${var.hostname}.${substr(data.google_dns_managed_zone.default.dns_name, 0, length(data.google_dns_managed_zone.default.dns_name) - 1)}"
}

resource "google_dns_record_set" "default" {
  name = "${var.hostname}.${data.google_dns_managed_zone.default.dns_name}"
  type = "A"
  ttl  = 300

  managed_zone = "${data.google_dns_managed_zone.default.name}"
  project      = "production-244305" # ?

  rrdatas = ["${google_compute_global_address.default.address}"]
}


resource "google_compute_managed_ssl_certificate" "default" {
  provider = "google-beta"
  name     = "${replace(local.drone_server_host, ".", "-")}"

  managed {
    domains = ["${local.drone_server_host}"]
  }

  depends_on = [
    # Issue certificate with existing A record.
    "google_dns_record_set.default"
  ]
}

resource "google_compute_global_address" "default" {
  name = "${replace(local.drone_server_host, ".", "-")}"
}