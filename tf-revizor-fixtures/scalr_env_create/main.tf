
terraform {
  required_providers {
    scalr = {
      source  = "registry.scalr.io/scalr/scalr"
      version = "1.4.0"
    }
  }
}

data "scalr_current_account" "data_acc" {}

output "out_acc" {
  value = yamlencode(data.scalr_current_account.data_acc)
}

resource "scalr_environment" "dana_env" {
  name       = "test-env"
  account_id = data.scalr_current_account.data_acc.id
  cost_estimation_enabled = false
}

output "out_env" {
  value = scalr_environment.dana_env.id
}

