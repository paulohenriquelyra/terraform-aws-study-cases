# NOTA: data "aws_availability_zones" "all" foi removido pois usaremos subnets específicas
# fornecidas pela variável public_subnet_ids.

# Busca a AMI mais recente do Amazon Linux 2
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Data source: Template file
data "template_file" "user_data" {
  template = file("${path.module}/user-data.sh")
  
  vars = {
    server_port = var.server_port
	db_address  = var.db_address
	db_port     = var.db_port
  }
}

# Create a Security Group for an EC2 instance
resource "aws_security_group" "instance" {
  name   = "${var.cluster_name}-instance"
  vpc_id = var.vpc_id
  
  ingress {
    description              = "Allow traffic from the ELB"
    from_port                = var.server_port
    to_port                  = var.server_port
    protocol                 = "tcp"
    security_groups          = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

# Create a Security Group for an ELB
resource "aws_security_group" "alb" {
  name   = "${var.cluster_name}-elb"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a Launch Template
resource "aws_launch_template" "example" {
  name_prefix   = "${var.cluster_name}-lt-"
  image_id      = data.aws_ami.amazon_linux_2.id
  instance_type = var.instance_type
  user_data     = base64encode(data.template_file.user_data.rendered) # user_data em Launch Templates precisa ser base64 encoded
  vpc_security_group_ids = [aws_security_group.instance.id]
  
  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "${var.cluster_name}-instance"
    }
  }
}

# Create an Autoscaling Group
resource "aws_autoscaling_group" "example" {
  launch_template {
    id      = aws_launch_template.example.id
    version = "$Latest" # Usa a versão mais recente do Launch Template
  }
  vpc_zone_identifier  = var.public_subnet_ids
  target_group_arns    = [aws_lb_target_group.asg.arn]
  health_check_type    = "ELB" # Continues to use ELB health checks, managed by the target group
  health_check_grace_period = 300
  
  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-instance"
    propagate_at_launch = true
  }
}

# Create an Application Load Balancer
resource "aws_lb" "example" {
  name               = var.cluster_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnet_ids

  # For production, this should be true
  enable_deletion_protection = false
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}

resource "aws_lb_target_group" "asg" {
  name     = "${var.cluster_name}-tg"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}
