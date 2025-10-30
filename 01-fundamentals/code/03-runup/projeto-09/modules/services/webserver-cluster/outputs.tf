# Output variable: DNS Name of ELB
output "elb_dns_name" {
  value = aws_lb.example.dns_name
}

# Output variable: Auto Scaling Group name
output "asg_name" {
  value = aws_autoscaling_group.example.name
}

# Output variable: ELB Security Group Id
output "elb_security_group_id" {
  value = aws_security_group.alb.id
}

# Output variable: Instance Security Group Id
output "instance_security_group_id" {
  description = "The ID of the security group for the EC2 instances"
  value       = aws_security_group.instance.id
}
