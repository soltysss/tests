
variable "secret" {
  default   = "xxxxxxxxx"
  sensitive = true
}

resource "null_resource" "nothing" {
  triggers = {
    name   = var.secret
  }
}

output "the_id" {
value       = "${null_resource.nothing.id} xxxxxxxxx"
description = "Sensitive null resource id"
sensitive   = true
}
