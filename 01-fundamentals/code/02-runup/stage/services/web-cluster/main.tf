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

# Obtém uma lista de todas as Zonas de Disponibilidade (AZs) disponíveis na região configurada.
data "aws_availability_zones" "available" {
  state = "available"
}

# -------------------------------------------------------------------------------------------------
# RECURSOS DE REDE (NETWORKING)
# -------------------------------------------------------------------------------------------------
# Cria a Virtual Private Cloud (VPC), que é a rede virtual isolada para seus recursos.
resource "aws_vpc" "example" {
  cidr_block = var.vpc_cidr_block

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-vpc"
  })
}

# Cria um Internet Gateway (IGW) e o anexa à VPC para permitir a comunicação com a internet.
resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-igw"
  })
}

# Cria uma Tabela de Rotas PÚBLICA.
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id # Rota para a Internet
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-rt"
  })
}

# Cria as sub-redes públicas.
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.example.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-subnet-public-${data.aws_availability_zones.available.names[count.index]}"
  })
}

# Associa a tabela de rotas pública com cada uma das sub-redes públicas criadas.
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Cria um Elastic IP (EIP) para o NAT Gateway.
resource "aws_eip" "nat" {
  vpc = true

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-nat-eip"
  })
}

# Cria um NAT Gateway na primeira sub-rede pública.
resource "aws_nat_gateway" "example" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-nat-gw"
  })

  depends_on = [aws_internet_gateway.example]
}

# Cria uma Tabela de Rotas PRIVADA.
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.example.id # Rota para o NAT Gateway
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-rt-private"
  })
}

# Cria as sub-redes privadas.
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id                  = aws_vpc.example.id
  cidr_block              = var.private_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = false

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-subnet-private-${data.aws_availability_zones.available.names[count.index]}"
  })
}

# Associa a tabela de rotas privada com cada uma das sub-redes privadas criadas.
resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
}