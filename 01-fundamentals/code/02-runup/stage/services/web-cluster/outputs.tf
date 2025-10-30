output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.example.id
}

output "public_subnet_ids" {
  description = "List of IDs of the public subnets."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "private_subnet_ids" {
  description = "List of IDs of the private subnets."
  value       = [for subnet in aws_subnet.private : subnet.id]
}