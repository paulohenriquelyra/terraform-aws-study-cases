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

# Busca os outputs do estado remoto do componente de banco de dados
data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "terraform-up-and-running-state-20251024"
    key    = "03-runup/projeto-09/stage/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"
  }
}

# Use Module
module "webserver_cluster" {
  source = "../../../modules/services/webserver-cluster"
  
  cluster_name           = "werservers-stage"
  db_address        = data.terraform_remote_state.db.outputs.address
  db_port           = data.terraform_remote_state.db.outputs.port
  vpc_id            = data.terraform_remote_state.networking.outputs.vpc_id
  public_subnet_ids = data.terraform_remote_state.networking.outputs.public_subnet_ids
  
  instance_type = "t2.micro"
  min_size      = 2
  max_size      = 2
}

# Cria uma regra de Security Group para permitir que as instâncias do webserver
# se conectem ao RDS. Esta regra é adicionada ao Security Group do RDS.
resource "aws_security_group_rule" "allow_web_to_rds" {
  type                     = "ingress"
  from_port                = 3306 # Porta padrão do MySQL
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = module.webserver_cluster.instance_security_group_id
  security_group_id        = data.terraform_remote_state.db.outputs.rds_security_group_id
}

# Create a Security Group Rule
resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
