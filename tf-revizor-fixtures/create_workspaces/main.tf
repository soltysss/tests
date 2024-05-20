terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version = "~> 1.0"
        }
    }
}

data "scalr_current_account" "data_acc" {}

output "out_acc" {
  value = yamlencode(data.scalr_current_account.data_acc)
}

data "scalr_vcs_provider" "sts_vcs" {
  name = "sts"
}

resource "scalr_workspace" "ws_vcs" {
  name            = "workspaces-${count.index}"
  count = 10
  auto_queue_runs = "never"
  environment_id  = "env-svrcnchebt61e30"
  vcs_provider_id = data.scalr_vcs_provider.sts_vcs.id
  auto_apply = true

  working_directory = var.ws_vcs_workdir

  vcs_repo {
    identifier = var.ws_vcs_repo_identifier
    branch     = var.ws_vcs_repo_branch
  }

}

variable "ws_vcs_repo_identifier" {
  description = "'vcs_repo.indentifier' used to create workspace"
  default     = "soltysss/tests"
}
variable "ws_vcs_repo_branch" {
  description = "'vcs_repo.branch' used to create workspace"
  default     = "main"
}
variable "ws_vcs_workdir" {
  description = "Working directory (path) used to create workspace. Submit blank if configuration is located in the repository root."
  default     = "tf-revizor-fixtures/local_wait2"
}


resource "scalr_workspace_run_schedule" "example" {
  for_each = scalr_workspace.ws_vcs
  workspace_id     = each.value.id
  apply_schedule   = "*/5 * * * *"
  destroy_schedule = "*/6 * * * *"
}
