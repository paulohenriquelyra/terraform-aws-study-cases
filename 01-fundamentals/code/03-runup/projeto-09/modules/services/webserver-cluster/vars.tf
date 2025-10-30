# Input variable: server port
variable "server_port" {
  description = "The port the server will use for HTTP requests"
  default = "80"
}

# Input variable: Cluster name
variable "cluster_name" {
  description = "The name to use for all the cluster resources"
}

# Input variable: DB Address
variable "db_address" {
  description = "The address of the database"
}

# Input variable: DB Port
variable "db_port" {
  description = "The port of the database"
}

# Input variable: Instance type
variable "instance_type" {
  description = "The type of EC2 Instances to run (e.g. t2.micro)"
}

# Input variable: Instance min size
variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
}

# Input variable: VPC ID
variable "vpc_id" {
  description = "The ID of the VPC to deploy resources into"
  type        = string
}

# Input variable: Public Subnet IDs
variable "public_subnet_ids" {
  description = "A list of public subnet IDs for the web servers and ELB"
  type        = list(string)
}
# Input variable: Instance max size
variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
}
