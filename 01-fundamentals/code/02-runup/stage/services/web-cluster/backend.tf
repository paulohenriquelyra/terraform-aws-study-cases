terraform {
  backend "s3" {
    bucket = "terraform-up-and-running-state-20251024"

    # Chave única para o estado da rede
    key = "01-fundamentals/stage/networking/terraform.tfstate"

    region = "us-east-1"

    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}