# Output variable: DB instance address
output "address" {
  value = aws_db_instance.example.address
}

# Output variable: DB instance port
output "port" {
  value = aws_db_instance.example.port
}

# Output variable: DB Security Group ID
output "security_group_id" {
  value = aws_security_group.db_sg.id
}
