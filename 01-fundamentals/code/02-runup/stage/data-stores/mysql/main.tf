# Define os provedores necessários para esta configuração.
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configura o provedor AWS, definindo a região onde os recursos serão criados.
provider "aws" {
  region = var.aws_region
}

# Define variáveis locais para tags comuns.
locals {
  common_tags = {
    Project = var.project_name
  }
}

# Data Source para ler o estado remoto do componente web-cluster.
# Isso nos permite acessar os outputs (como IDs da VPC e sub-redes)
# para conectar o banco de dados à rede correta. A rede é criada pelo web-cluster.
data "terraform_remote_state" "networking" {
  backend = "s3"

  config = {
    bucket = "terraform-up-and-running-state-20251024" # O bucket do backend
    key    = "01-fundamentals/stage/networking/terraform.tfstate" # A chave para o estado da rede
    region = "us-east-1"
  }
}

# Cria um grupo de sub-redes para o banco de dados.
# O RDS usará este grupo para saber em quais sub-redes (e Zonas de Disponibilidade) ele pode ser implantado.
resource "aws_db_subnet_group" "example" {
  name       = "${var.project_name}-db-subnet-group" # O nome do grupo de sub-redes
  subnet_ids = data.terraform_remote_state.networking.outputs.private_subnet_ids # Usar as sub-redes privadas

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-db-subnet-group"
  })
}

# Cria um Security Group (firewall) para a instância do banco de dados.
resource "aws_security_group" "db_sg" {
  name        = "${var.project_name}-db-sg"
  description = "Allows database connections. Ingress is managed by web-cluster."
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-db-sg"
  })
}

# Cria a instância do banco de dados RDS.
resource "aws_db_instance" "example" {
  # O identificador único para a instância RDS.
  identifier          = "${var.project_name}-db"

  engine              = "mysql"
  allocated_storage   = var.db_allocated_storage
  instance_class      = var.db_instance_class
  db_name             = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true

  # Associa a instância ao grupo de sub-redes para colocá-la na nossa VPC.
  db_subnet_group_name = aws_db_subnet_group.example.name

  # Associa o Security Group que acabamos de criar à instância do RDS.
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-db-instance"
  })
}
