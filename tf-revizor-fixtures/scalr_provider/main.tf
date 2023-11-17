resource "scalr_provider_configuration" "scalr" {
  name       = "scalr"
  account_id = "acc-svrcncgh453bi8g"
}


provider "scalr" {
  hostname = var.scalr_host_name
  token    = var.scalr_api_token
}

resource "scalr_variable" "example" {
  key          = "my_key_name"
  value        = "my_value_name"
  category     = "terraform"
  description  = "variable description"
}
