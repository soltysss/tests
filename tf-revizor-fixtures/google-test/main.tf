terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.43"
    }
  }
}

locals {
  env_labels = {
    environment = "test"
    managed_by  = "scalr"
  }
}

provider "google" {
  project = "sacred-epigram-480016-u0"
  region  = "us-central1"
  default_labels = merge(local.env_labels, {
    my_global_keys = "one"
    my_default_key = "two"
  })
}

resource "google_pubsub_topic" "test" {
  name = "scalr-labels-test"
}
