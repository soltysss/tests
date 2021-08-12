variable "run_id" {
  default = "yyyyyy"
}

variable "sleep_time" {
  default = 30
}

variable "sens" {
  default   = "xxxxxx"
  sensitive = true
}

resource "random_integer" "timeout" {
  min = 30
  max = 180

  keepers = {
    run_id = var.run_id
  }
}

resource "null_resource" "wait" {
  triggers = {
    run_id = var.run_id
    name   = var.sens
  }
  provisioner "local-exec" {
    command = "sleep ${var.sleep_time}"
  }
}

module "local-wait" {
  source = "./modules/local-wait"
  secret = var.sens
}



output "very_long" {
  value = "Lorem ipsum dolor sit amet, consectetur adipiscing elit"
}

output "test" {
  value = "laborum ${var.sens}"
  sensitive = true
}

output "senc_out" {
  value       = "xxxxxx"
  description = "my sensitive output"
  sensitive   = true
}

output "module_res" {
  value = "${module.local-wait.the_id} xxxxxx"
  sensitive = true
}
