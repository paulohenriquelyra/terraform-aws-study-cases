# Define os provedores necessários para esta configuração, garantindo que uma versão específica do provedor AWS seja usada.
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

# Define variáveis locais. Aqui, criamos um conjunto de tags comuns para serem aplicadas
# de forma consistente em todos os recursos, para melhor organização e rastreamento de custos.
locals {
  common_tags = {
    Project = var.project_name
  }
}

# -------------------------------------------------------------------------------------------------
# FONTES DE DADOS (DATA SOURCES)
# -------------------------------------------------------------------------------------------------
# Encontra dinamicamente a Imagem de Máquina da Amazon (AMI) mais recente para o Amazon Linux 2.
# Isso evita ter que fixar um ID de AMI no código, que pode se tornar obsoleto.
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Obtém uma lista de todas as Zonas de Disponibilidade (AZs) disponíveis na região configurada.
# Isso permite a criação de recursos de forma distribuída para alta disponibilidade.
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

# Cria uma Tabela de Rotas para a VPC. A rota definida aqui direciona todo o tráfego
# destinado à internet (0.0.0.0/0) para o Internet Gateway.
resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-rt"
  })
}

# Cria as sub-redes públicas. O `count` garante que uma sub-rede seja criada em cada
# Zona de Disponibilidade, proporcionando alta disponibilidade.
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id                  = aws_vpc.example.id
  cidr_block              = var.public_subnet_cidrs[count.index]
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true # Assign public IPs to instances in this subnet

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-subnet-public-${data.aws_availability_zones.available.names[count.index]}"
  })
}

# -------------------------------------------------------------------------------------------------
# SEGURANÇA (SECURITY)
# -------------------------------------------------------------------------------------------------
# Cria um Security Group (firewall) para o Load Balancer.
# Ele permite tráfego de entrada na porta 80 (HTTP) de qualquer lugar da internet.
resource "aws_security_group" "lb_sg" {
  name        = "${var.project_name}-lb-sg"
  description = "Permite tráfego web para o load balancer"
  vpc_id      = aws_vpc.example.id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-lb-sg"
  })
}

# Cria um Security Group para as instâncias EC2.
# Ele permite tráfego web (porta 8080) apenas vindo do Load Balancer e tráfego SSH (porta 22) de qualquer lugar.
resource "aws_security_group" "instance_sg" {
  name        = "${var.project_name}-instance-sg"
  description = "Permite tráfego web vindo do LB e tráfego SSH"
  vpc_id      = aws_vpc.example.id

  ingress {
    description = "Permite tráfego web vindo do Load Balancer"
    from_port   = var.web_server_port
    to_port     = var.web_server_port
    protocol    = "tcp"
    security_groups = [aws_security_group.lb_sg.id]
  }

  ingress {
    description = "Permite SSH de qualquer lugar (apenas para teste)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-instance-sg"
  })
}

# Cria um Par de Chaves (Key Pair) na AWS fazendo o upload de uma chave pública local.
# Isso permite o acesso seguro às instâncias via SSH.
resource "aws_key_pair" "deployer" {
  key_name   = "${var.project_name}-key"
  public_key = file(var.public_key_path)
}

# Associa a tabela de rotas pública com cada uma das sub-redes públicas criadas.
resource "aws_route_table_association" "example" {
  count = length(aws_subnet.public)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.example.id
}

# -------------------------------------------------------------------------------------------------
# COMPUTE (LOAD BALANCER E AUTO SCALING)
# -------------------------------------------------------------------------------------------------
# Cria um Application Load Balancer (ALB) público, que servirá como ponto de entrada para a aplicação.
resource "aws_lb" "example" {
  name               = "${var.project_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-lb"
  })
}

# Cria um Target Group (Grupo de Destino). O ALB encaminhará o tráfego para as instâncias registradas neste grupo.
# Também define as regras de verificação de saúde (Health Check) para monitorar as instâncias.
resource "aws_lb_target_group" "example" {
  name     = "${var.project_name}-tg"
  port     = var.web_server_port
  protocol = "HTTP"
  vpc_id   = aws_vpc.example.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = merge(local.common_tags, {
    Name = "${var.project_name}-tg"
  })
}

# Cria um Listener para o Load Balancer. Ele "escuta" por tráfego na porta 80 (HTTP)
# e o encaminha para o Target Group definido acima.
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.example.arn
  }
}

# Cria um Launch Template. Este é um modelo que o Auto Scaling Group usará para criar novas instâncias EC2,
# definindo a AMI, tipo de instância, script de inicialização (user_data), etc.
resource "aws_launch_template" "example" {
  name_prefix   = "${var.project_name}-"
  image_id               = data.aws_ami.amazon_linux_2.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  key_name               = aws_key_pair.deployer.key_name

  user_data = base64encode(templatefile("${path.module}/user_data.sh.tpl", {
    web_port      = var.web_server_port
    ssh_user      = var.ssh_user
    ssh_password  = var.ssh_password # A senha é marcada como sensível na variável
    web_page_text = "alo todos"
  }))

  tag_specifications {
    resource_type = "instance"
    tags = merge(local.common_tags, {
      Name = "${var.project_name}-instance"
    })
  }
}

# Cria o Auto Scaling Group (ASG). Ele gerencia automaticamente o número de instâncias EC2,
# garantindo que o número desejado (entre min/max) esteja sempre em execução e saudável,
# distribuindo-as entre as sub-redes para alta disponibilidade.
resource "aws_autoscaling_group" "example" {
  name                = "${var.project_name}-asg"
  vpc_zone_identifier = [for subnet in aws_subnet.public : subnet.id]

  desired_capacity = 2
  min_size         = 2
  max_size         = 4

  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest"
  }

  target_group_arns = [aws_lb_target_group.example.arn]

  # Garante que as atualizações de instância (ex: ao mudar o launch template) sejam feitas de forma gradual (rolling update).
  instance_refresh {
    strategy = "Rolling"
    preferences {
      min_healthy_percentage = 50
    }
  }
}