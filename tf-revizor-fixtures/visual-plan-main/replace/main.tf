variable "strings" {
  default = ["a","b2","c","d", "e"]
}

resource "random_shuffle" "my_shuffle" {
  input = var.strings
  result_count = length(var.strings)
}

output "shuffle_out" {
  value = random_shuffle.my_shuffle.result
  description = "123456789"
  sensitive = false
}
