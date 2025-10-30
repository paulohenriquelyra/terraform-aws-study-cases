variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "A name for the project to prefix resources."
  type        = string
  default     = "tf-example"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for the public subnets."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "instance_type" {
  description = "The EC2 instance type."
  type        = string
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Path to the SSH public key file."
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "web_server_port" {
  description = "The port for the web server to listen on."
  type        = number
  default     = 8080
}

variable "ssh_user" {
  description = "The username to create for SSH access."
  type        = string
  default     = "paulo"
}

variable "ssh_password" {
  description = "The password for the new SSH user. WARNING: For testing only."
  type        = string
  default     = "t*st3123"
  sensitive   = true
}