resource "terraform_data" "that" {
  count = 20
  input = "something"
}
