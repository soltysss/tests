terraform {
    required_providers {
        scalr = {
            source = "registry.scalr.io/scalr/scalr"
            version= "1.6.0"
        }
    }
}

data "scalr_current_account" "data_acc" {}

output "out_acc" {
  value = yamlencode(data.scalr_current_account.data_acc)
}


resource "scalr_environment" "sts_env" {
  name       = "sts-env"
  account_id = data.scalr_current_account.data_acc.id
  cost_estimation_enabled = true
}
data "scalr_environment" "data_env" {
  name = scalr_environment.sts_env.name # optional, can only use id or name for the environment filter, if both are used there will be a conflict.
}

output "out_env" {
  value = yamlencode(data.scalr_environment.data_env)
}

data "scalr_vcs_provider" "sts_vcs" {
  name = "sts"
}

output "out_vcs" {
  value = yamlencode(data.scalr_vcs_provider.sts_vcs)
}


resource "scalr_workspace" "ws_vcs" {
  name            = "workspaces-${count.index}"
  count = 50
  auto_queue_runs = "never"
  environment_id  = scalr_environment.sts_env.id
  vcs_provider_id = data.scalr_vcs_provider.sts_vcs.id

  working_directory = var.ws_vcs_workdir

  vcs_repo {
    identifier = var.ws_vcs_repo_identifier
    branch     = var.ws_vcs_repo_branch
  }

}

variable "ws_vcs_repo_identifier" {
  description = "'vcs_repo.indentifier' used to create workspace"
  default     = "soltysss"
}
variable "ws_vcs_repo_branch" {
  description = "'vcs_repo.branch' used to create workspace"
  default     = "main"
}
variable "ws_vcs_workdir" {
  description = "Working directory (path) used to create workspace. Submit blank if configuration is located in the repository root."
  default     = "tf-revizor-fixtures/local_wait"
}
data "scalr_workspace" "data_ws" {
  name           = scalr_workspace.ws_vcs[0].name
  environment_id = scalr_environment.sts_env.id
}
output "out_ws" {
  value = yamlencode(data.scalr_workspace.data_ws)
}

resource "scalr_variable" "var_env" {
key            = "TF_LOG"
value          = "TRACE"
category       = "shell"
environment_id = scalr_environment.sts_env.id
}
data "scalr_variables" "data_vars" {
  category = "shell"
}

output "out_vars" {
  value = yamlencode(data.scalr_variables.data_vars)
}
resource "scalr_workspace" "cli-driven" {
  name            = "cli_ws"
  environment_id  = scalr_environment.sts_env.id
}
resource "scalr_role" "role" {
  name        = "role_${formatdate("DDMMYYYY", timestamp())}"
  description = "Regression: *:* permissions"

  permissions = [
    "*:read",
    "*:update",
    "*:delete",
    "*:create"
  ]
}
resource "scalr_iam_team" "team" {
  name        = "dev"
  description = "Regression ${formatdate("DDMMYYYY", timestamp())}"
  account_id  =  data.scalr_current_account.data_acc.id

  users = ["user-v0o818va5994aviu9"]
}
