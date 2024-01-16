resource "null_resource" "single" {
  triggers = {
    time = timestamp()
  }
}

output  "time" {
  value = timestamp()
}
