# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# Create a S3 bucket
resource "aws_s3_bucket" "terraform_state" {
  # O bucket deve ser criado na mesma região que o provedor.
  # Para us-east-1, não é necessário location_constraint.
  bucket = var.bucket_name

  lifecycle {
    prevent_destroy = true
  }
}

# Habilita o versionamento no bucket S3 usando o recurso dedicado
resource "aws_s3_bucket_versioning" "terraform_state_versioning" {
  bucket = aws_s3_bucket.terraform_state.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Cria uma tabela DynamoDB para o travamento de estado (state locking)
resource "aws_dynamodb_table" "terraform_state_lock" {
  name         = "terraform-state-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
