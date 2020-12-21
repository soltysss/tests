provider "aws" {
  region     = var.region
}
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name1"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}
resource "aws_instance" "test_instance1" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet
  associate_public_ip_address = var.associate_public_ip
  tags = {
    owner = var.owner 
    }
}
output "public_ip" {
 value = aws_instance.test_instance1.public_ip
 description = "text"
}
