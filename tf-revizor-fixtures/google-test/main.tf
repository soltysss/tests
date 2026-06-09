  terraform {
    required_providers {
      google = {
        source  = "hashicorp/google"
        version = "~> 5.0"
      }
    }
  }

  provider "google" {
    project = "sacred-epigram-480016-u0"
    region  = "us-central1"
  }

  resource "google_pubsub_topic" "test" {
    name = "scalr-labels-test"
  }

