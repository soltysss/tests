terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Wrapper module — calls the actual module under test (simulates a private-registry module call)
module "gl10_test" {
  source = "./child"
}

output "account_id" {
  value = module.gl10_test.account_id
}