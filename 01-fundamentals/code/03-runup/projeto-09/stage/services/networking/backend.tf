# Configura o backend do Terraform para armazenar o arquivo de estado (tfstate) de forma remota e segura no AWS S3.
terraform {
  backend "s3" {
    # O nome do bucket S3 onde o arquivo de estado será armazenado.
    # Este bucket deve ser criado separadamente (pelo projeto 'global/s3').
    bucket = "terraform-up-and-running-state-20251024"

    # O caminho/nome do arquivo de estado dentro do bucket.
    # Este caminho é exclusivo para o componente de rede do ambiente de stage.
    key = "03-runup/projeto-09/stage/networking/terraform.tfstate"

    # A região da AWS onde o bucket S3 e a tabela DynamoDB estão localizados.
    region = "us-east-1"

    # Habilita o travamento de estado para prevenir execuções simultâneas.
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}