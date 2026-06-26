provider "aws" {
  region = "us-east-2"
}

run "test_caller_identity" {
  command = plan

  assert {
    condition     = length(output.account_id) > 0
    error_message = "Expected non-empty account_id."
  }
}