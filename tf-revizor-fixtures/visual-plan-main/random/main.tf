resource "random_string" "test" {
  count = var.string_count
  length = var.string_length
}
variable "string_count" {
  sensitive = false
}
variable "string_length" {
  sensitive = false
  default = "1000"
}

