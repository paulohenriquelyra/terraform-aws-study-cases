# Define Terraform backend using a S3 bucket for storing the Terraform state
terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-20251024"
    key    = "03-runup/projeto-09/prod/data-stores/mysql/terraform.tfstate"
    region = "us-east-1"

    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
