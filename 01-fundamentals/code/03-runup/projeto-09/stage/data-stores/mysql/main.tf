# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Busca os outputs do estado remoto do componente de rede
data "terraform_remote_state" "networking" {
  backend = "s3"
  config = {
    bucket = "terraform-up-and-running-state-20251024"
    key    = "03-runup/projeto-09/stage/networking/terraform.tfstate"
    region = "us-east-1"
  }
}

# Cria um grupo de subnets para o RDS, usando as subnets privadas da nossa VPC
resource "aws_db_subnet_group" "default" {
  name       = "db-subnet-group-stage"
  subnet_ids = data.terraform_remote_state.networking.outputs.private_subnet_ids

  tags = {
    Name = "db-subnet-group-stage"
  }
}

# Cria um Security Group para a instância do RDS
resource "aws_security_group" "rds" {
  name        = "rds-sg-stage"
  description = "Allow traffic to RDS from the webserver security group"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id

  tags = {
    Name = "rds-sg-stage"
  }
}

# Create a DB instance
resource "aws_db_instance" "example" {
  engine              = "mysql"
  engine_version      = "5.7"
  allocated_storage   = 10
  instance_class      = "db.t3.micro"
  identifier           = "db-stage-09"
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  db_name             = "example_database_stage"
  username            = "admin"
  password            = "${var.db_password}"
  skip_final_snapshot = true
}
