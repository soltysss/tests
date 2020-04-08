variable "region" {
  description = "AWS region to launch the VM into"
  default     = "us-east-1"
}

variable "instance_type" {
  default = "t2.medium"
}

variable "subnet_id" {
  description = "VPC Subnet into which to launch your instance"
  default     = "subnet-3d82d101"
}
