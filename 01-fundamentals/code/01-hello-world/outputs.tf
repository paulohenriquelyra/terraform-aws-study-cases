output "load_balancer_dns" {
  description = "DNS name of the Application Load Balancer."
  value       = aws_lb.example.dns_name
}

output "vpc_id" {
  description = "ID of the VPC."
  value       = aws_vpc.example.id
}

output "subnet_id" {
  description = "ID of the public subnet."
  value       = [for subnet in aws_subnet.public : subnet.id]
}

output "security_group_id" {
  description = "ID of the instance security group."
  value       = aws_security_group.instance_sg.id
}