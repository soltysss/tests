terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

variable "access_key" {
  type        = string
  description = "Placeholder credential. The plan never calls the AWS API."
  default     = "mock_access_key"
}

variable "secret_key" {
  type        = string
  description = "Placeholder credential. The plan never calls the AWS API."
  default     = "mock_secret_key"
}

variable "enable_public_ssh" {
  type        = bool
  description = "Create the security group that allows SSH from anywhere."
  default     = true
}

# The provider needs a credential pair to configure itself, but the skips keep it from calling STS,
# IMDS or the region endpoint, so the plan runs without any real credentials.
provider "aws" {
  region                      = "us-east-1"
  access_key                  = var.access_key
  secret_key                  = var.secret_key
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_region_validation      = true
  skip_requesting_account_id  = true
}

# Only this resource is conditional: a plan-based scan reports it when the plan creates it, a code
# scan reports it either way.
resource "aws_security_group" "open_ssh" {
  count       = var.enable_public_ssh ? 1 : 0
  name        = "checkov-plan-open-ssh"
  description = "Open SSH to the world"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_ebs_volume" "unencrypted" {
  availability_zone = "us-east-1a"
  size              = 1
  encrypted         = false
}

resource "aws_s3_bucket" "plain" {
  bucket = "checkov-plan-mode-fixture"
}
