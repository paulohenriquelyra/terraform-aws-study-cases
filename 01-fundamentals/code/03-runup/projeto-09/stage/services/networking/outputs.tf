# ID da VPC criada
output "vpc_id" {
  description = "O ID da VPC para o ambiente de stage"
  value       = aws_vpc.main.id
}

# Lista de IDs das subnets públicas
output "public_subnet_ids" {
  description = "Lista de IDs das subnets públicas"
  value       = aws_subnet.public[*].id
}

# Lista de IDs das subnets privadas
output "private_subnet_ids" {
  description = "Lista de IDs das subnets privadas para o banco de dados"
  value       = aws_subnet.private[*].id
}