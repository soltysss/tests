resource "random_id" "app_id" {
  byte_length = 4
}

locals {
  id = random_id.app_id.hex
}
