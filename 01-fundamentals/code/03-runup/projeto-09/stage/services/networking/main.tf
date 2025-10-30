# Configura o provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Obtém a lista de Zonas de Disponibilidade (AZs) disponíveis na região
data "aws_availability_zones" "available" {
  state = "available"
}

# Cria a VPC para o ambiente de stage
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  # Habilita a resolução de DNS dentro da VPC
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "vpc-stage"
  }
}

# Cria o Internet Gateway para permitir acesso à internet para a VPC
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw-stage"
  }
}

# Cria a tabela de rotas para as subnets públicas
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  # Adiciona uma rota para a internet através do Internet Gateway
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "rt-public-stage"
  }
}

# Cria duas subnets públicas em AZs diferentes para alta disponibilidade
resource "aws_subnet" "public" {
  count = 2

  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.${100 + count.index}.0/24"
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true # Instâncias aqui recebem IP público

  tags = {
    Name = "subnet-public-stage-${count.index + 1}"
  }
}

# Associa as subnets públicas à tabela de rotas pública
resource "aws_route_table_association" "public" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}

# Cria duas subnets privadas em AZs diferentes para o banco de dados
resource "aws_subnet" "private" {
  count = 2

  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  tags = {
    Name = "subnet-private-stage-${count.index + 1}"
  }
}

# (Opcional, mas recomendado) Cria um NAT Gateway para permitir que
# recursos em subnets privadas acessem a internet para atualizações, etc.
# Para simplificar e manter o custo baixo, este exemplo não inclui um NAT Gateway.
# Se necessário, você adicionaria aqui os recursos aws_eip, aws_nat_gateway,
# uma tabela de rotas privada e a associação.