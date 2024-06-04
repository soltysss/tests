resource "null_resource" "test" {
  count = 1000
  triggers = {
    trigger = timestamp()
  }
}

