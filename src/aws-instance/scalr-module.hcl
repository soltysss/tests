version = "v1"

variable "region" {
  policy = "cloud.locations"
  conditions = {
    cloud = "ec2"
  }
}

variable "instance_type" {
  policy = "cloud.instance.types"
  conditions = {
    cloud = "ec2"
    cloud.location = "${var.region}"
  }
}

variable "subnet_id" {
  policy = "cloud.subnets"
  conditions = {
    cloud = "ec2"
    cloud.location = "${var.region}"
    cloud.network = "vpc-596aa03e"
  }
}
