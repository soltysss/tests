provider "google" {
  project     = "${var.project}"
  region      = "${var.region}"
  version     = "~> 2.11.0"
}

provider "google-beta" {
  project     = "${var.project}"
  region      = "${var.region}"
  version     = "~> 2.11.0"
}

provider "kubernetes" {
  config_context_cluster = "${var.k8s_cluster_context}"
}