variable "region" {
  type = string
  default = "us-east-1"
}
variable "instance_type" {
  type = string
}
variable "network" {
  type = string
}
variable "subnet" {
  type = string
}
variable "associate_public_ip" {
  type    = bool
  default = true
}

variable "owner" {
  type    = string
}

output "superlongoutputname1234567dfjknaslkdjlasdjlaksjdaslkdsa" {
  value = var.region
}
