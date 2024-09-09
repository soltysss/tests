
terraform {
  backend "remote" {
    hostname = "mainiacp.soltys-test.testenv.scalr.dev"
    organization = "env-svrcnchebt61e30"
    workspaces {
      name = "access_remote_state"
    }
  }
}


variable "run_id" {
  default = "sdsdsd"
}

variable "sleep_time" {
  default = 30
}

variable "env" {
  default = "tfenv1"
}

variable "ws" {
  default = "wait"
}


resource "null_resource" "null" {
  triggers = {
    run_id = var.run_id
  }
  provisioner "local-exec" {
    command = "sleep ${var.sleep_time}"
  }
}

data "terraform_remote_state" "wait" {
  backend = "remote"

  config = {
    organization = var.env
    workspaces = {
      name = var.ws
    }
  }
}



output "very_long" {
  value = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"  
}

output "bla" {
    value = "follow the <a href='https://docs.scalr.io/docs/scalr'>documentation </a> on how to enable"
}

output "foo" {
    value = data.terraform_remote_state.wait.outputs.run_id
}


output "senc_out" {
  value = "secret data"
  description = "my sensitive output"
  sensitive = true
}
