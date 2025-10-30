# Configura o backend do Terraform para armazenar o arquivo de estado (tfstate) de forma remota e segura no AWS S3.
# O uso de um backend remoto é uma prática recomendada para colaboração em equipe e para evitar a perda do estado.
terraform {
  backend "s3" {
    # O nome do bucket S3 onde o arquivo de estado será armazenado.
    # Este bucket deve ser o mesmo usado por todos os componentes do projeto.
    bucket = "terraform-up-and-running-state-20251024"

    # O caminho/nome do arquivo de estado dentro do bucket.
    # A chave deve ser única para cada componente de estado (mysql, web-cluster, etc).
    key = "01-fundamentals/stage/data-stores/mysql/terraform.tfstate"

    # A região da AWS onde o bucket S3 e a tabela DynamoDB estão localizados.
    region = "us-east-1"

    # Habilita o travamento de estado para prevenir execuções simultâneas.
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
