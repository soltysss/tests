output "instance_id" {
  description = "Instance ID"
  value       = aws_instance.default.id
}

output "public_ip" {
  description = "Public IP"
  value       = aws_instance.default.public_ip
}

output "private_ip" {
  description = "Private IP"
  value       = aws_instance.default.private_ip
}
