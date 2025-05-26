
variable "secret" {
  default   = "xxxxxxx"
  sensitive = true
}

resource "null_resource" "nothing" {
  triggers = {
    name   = var.secret
  }
}

output "the_id" {
value       = "${null_resource.nothing.id} xxxxxxx"
description = "Sensitive null resource id"
sensitive   = true
}
