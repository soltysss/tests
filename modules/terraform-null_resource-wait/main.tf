
variable "secret" {
  default   = "xxxxxx"
  sensitive = true
}

resource "null_resource" "nothing" {
  triggers = {
    name   = var.secret
  }
}

output "the_id" {
value       = "${null_resource.nothing.id} xxxxxx"
description = "Sensitive null resource id"
sensitive   = true
}