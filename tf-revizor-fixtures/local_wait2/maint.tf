
variable "run_id" {
  default = "sdsdsd"
}

variable "sleep_time" {
  default = 30
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
  }
  provisioner "local-exec" {
    command = "sleep ${var.sleep_time}"
  }
}


output "very_long" {
  value = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum"  
}

output "bla" {
    value = "follow the <a href='https://docs.scalr.io/docs/scalr'>documentation </a> on how to enable"
}

output "senc_out" {
  value = "secret data"
  description = "my sensitive output"
  sensitive = true
}
