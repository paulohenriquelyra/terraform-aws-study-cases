# Output variable: DB instance address
output "address" {
  value = "${aws_db_instance.example.address}"
}

# Output variable: DB instance port
output "port" {
  value = "${aws_db_instance.example.port}"
}

# Output variable: RDS Security Group ID
output "rds_security_group_id" {
  description = "The ID of the security group for the RDS instance"
  value       = aws_security_group.rds.id
}
