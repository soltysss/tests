/**
 * In-cluster ingress controller.
 */

data "google_client_config" "default" {}

provider "helm" {
  version = "1.3.0"

  kubernetes {
    host                   = "https://${google_container_cluster.default.endpoint}"
    token                  = data.google_client_config.default.access_token
    cluster_ca_certificate = base64decode(google_container_cluster.default.master_auth[0].cluster_ca_certificate)
    load_config_file       = false
  }
}

resource "google_compute_address" "ingress_lb" {
  name   = "gke-ingress-${local.id}-address"
  region = var.region
}

locals {
  ingress_public_ip = google_compute_address.ingress_lb.address
}

resource "helm_release" "nginx_ingress" {
  name             = "nginx-ingress"
  repository       = "https://kubernetes.github.io/ingress-nginx"
  chart            = "ingress-nginx"
  namespace        = "nginx-ingress"
  create_namespace = true
  version          = "3.1.0"

  wait = true
  lint = true

  set {
    name  = "controller.config.http-snippet"
    value = <<EOT
  proxy_cache_path /tmp/nginx-cache levels=1:2 keys_zone=static-cache:2m max_size=100m inactive=7d use_temp_path=off;
  proxy_cache_key $scheme$proxy_host$request_uri;
  proxy_cache_lock on;
  proxy_cache_use_stale updating;
    EOT
  }

  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }

  set {
    name  = "controller.service.loadBalancerIP"
    value = local.ingress_public_ip
  }

  depends_on = [
    google_container_node_pool.gke,
  ]
}
