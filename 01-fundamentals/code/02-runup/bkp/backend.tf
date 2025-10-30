# Configura o backend do Terraform para armazenar o arquivo de estado (tfstate) de forma remota e segura no AWS S3.
# O uso de um backend remoto é uma prática recomendada para colaboração em equipe e para evitar a perda do estado.
terraform {
  backend "s3" {
    # O nome do bucket S3 onde o arquivo de estado será armazenado.
    # Este bucket deve ser criado separadamente (por exemplo, no projeto 'global/s3').
    bucket = "terraform-up-and-running-state-20251024"

    # O caminho/nome do arquivo de estado dentro do bucket.
    # Usar um caminho que reflete a estrutura do projeto ajuda a organizar os estados de diferentes ambientes.
    key = "01-fundamentals/stage/web-cluster/terraform.tfstate"

    # A região da AWS onde o bucket S3 e a tabela DynamoDB estão localizados.
    region = "us-east-1"

    # O nome da tabela do DynamoDB usada para o travamento do estado (state locking).
    # Isso previne que múltiplas execuções do Terraform ocorram simultaneamente.
    # dynamodb_table = "tf-example-terraform-state-lock-dynamodb"

    # Habilita a criptografia do lado do servidor para o arquivo de estado em repouso no S3.
    encrypt = true
  }
}