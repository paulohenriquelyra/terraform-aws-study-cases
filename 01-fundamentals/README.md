# 01 - Fundamentos de Terraform na AWS

Este diretório contém exemplos fundamentais de Terraform na AWS, organizados de forma progressiva do básico ao intermediário.

## 📚 Conteúdo

Os exemplos neste diretório são baseados principalmente no repositório [alfonsof/terraform-aws-examples](https://github.com/alfonsof/terraform-aws-examples), que segue o livro "Terraform: Up and Running" de Yevgeniy Brikman.

### Estrutura de Aprendizado

```
01-fundamentals/
├── 01-hello-world/              # Primeiro exemplo: deploy mínimo
├── 02-single-server/            # Deploy de servidor único completo
├── 03-webserver/                # Servidor web básico
├── 04-webserver-with-vars/      # Servidor web com variáveis
├── 05-cluster-webserver/        # Cluster com Auto Scaling
├── 06-s3-bucket/                # Criação de bucket S3
├── 07-state-management/         # Gerenciamento de estado
├── 08-file-layout/              # Estrutura de arquivos
├── 09-modules-intro/            # Introdução a módulos
├── 10-modules-multi-repo/       # Módulos em múltiplos repos
├── 11-loops/                    # Uso de loops
├── 12-conditionals/             # Condicionais if/else
├── 13-zero-downtime/            # Deploy sem downtime
└── README.md                    # Este arquivo
```

## 🎯 Objetivos de Aprendizado

Ao completar os exemplos deste diretório, você será capaz de:

- ✅ Entender a sintaxe básica do Terraform (HCL)
- ✅ Criar e gerenciar recursos AWS básicos (EC2, S3, ELB)
- ✅ Trabalhar com variáveis, outputs e data sources
- ✅ Gerenciar estado do Terraform (local e remoto)
- ✅ Organizar código em estrutura de arquivos adequada
- ✅ Criar e usar módulos reutilizáveis
- ✅ Implementar loops e condicionais
- ✅ Realizar deploys sem downtime

## 📖 Ordem Recomendada de Estudo

### Semana 1: Conceitos Básicos
1. **01-hello-world** - Primeiro contato com Terraform
2. **02-single-server** - Deploy completo de EC2
3. **03-webserver** - Servidor web funcional
4. **04-webserver-with-vars** - Parametrização

### Semana 2: Escalabilidade e Armazenamento
5. **05-cluster-webserver** - Auto Scaling e Load Balancer
6. **06-s3-bucket** - Armazenamento de objetos
7. **07-state-management** - Estado remoto e locking

### Semana 3: Organização e Modularização
8. **08-file-layout** - Estrutura de projeto
9. **09-modules-intro** - Criação de módulos
10. **10-modules-multi-repo** - Versionamento de módulos

### Semana 4: Recursos Avançados
11. **11-loops** - count, for_each, for
12. **12-conditionals** - if, ternary operators
13. **13-zero-downtime** - Blue-green deployment

## 🛠️ Pré-requisitos

Antes de começar, certifique-se de ter:

- ✅ Terraform instalado (>= 1.0)
- ✅ AWS CLI configurado
- ✅ Conta AWS (Free Tier recomendado)
- ✅ Editor de código (VS Code recomendado)
- ✅ Git instalado

Consulte [docs/GETTING_STARTED.md](../docs/GETTING_STARTED.md) para instruções detalhadas.

## 📝 Como Usar Cada Exemplo

### Estrutura Padrão de Cada Exemplo

```
exemplo/
├── main.tf           # Configuração principal
├── variables.tf      # Declaração de variáveis
├── outputs.tf        # Outputs do módulo
├── terraform.tfvars.example  # Exemplo de valores
└── README.md         # Documentação específica
```

### Workflow de Estudo

Para cada exemplo:

1. **Leia o README** do exemplo
2. **Analise o código** em `main.tf`
3. **Copie o arquivo de exemplo**:
   ```bash
   cp terraform.tfvars.example terraform.tfvars
   ```
4. **Edite valores** conforme necessário
5. **Execute os comandos**:
   ```bash
   terraform init
   terraform plan
   terraform apply
   ```
6. **Verifique no AWS Console** os recursos criados
7. **Experimente modificações**
8. **Documente aprendizados**
9. **Destrua recursos**:
   ```bash
   terraform destroy
   ```

## 💡 Conceitos-Chave por Exemplo

### 01-hello-world
- Providers
- Resources
- Terraform init/plan/apply/destroy

### 02-single-server
- AMI selection
- Security Groups
- Tags

### 03-webserver
- User data scripts
- Security group rules
- Outputs

### 04-webserver-with-vars
- Input variables
- Variable types
- Default values
- terraform.tfvars

### 05-cluster-webserver
- Auto Scaling Groups
- Launch Configurations
- Elastic Load Balancer
- Data sources

### 06-s3-bucket
- S3 bucket creation
- Bucket policies
- Versioning

### 07-state-management
- Remote state (S3)
- State locking (DynamoDB)
- Backend configuration

### 08-file-layout
- Estrutura de diretórios
- Ambientes (dev/staging/prod)
- Separação de concerns

### 09-modules-intro
- Module structure
- Module inputs/outputs
- Module versioning

### 10-modules-multi-repo
- Git-based modules
- Module versioning with tags
- Module registry

### 11-loops
- count parameter
- for_each
- for expressions

### 12-conditionals
- count for conditionals
- ternary operator
- dynamic blocks

### 13-zero-downtime
- Blue-green deployment
- create_before_destroy
- Lifecycle rules

## ⚠️ Avisos Importantes

### Custos AWS
- A maioria dos exemplos usa recursos do **Free Tier**
- **SEMPRE execute `terraform destroy`** após estudos
- Configure **alertas de billing** no AWS Console
- Revise recursos criados no Console AWS

### Segurança
- **NUNCA** commite arquivos `.tfvars` com credenciais
- Use `.gitignore` adequadamente
- Considere usar AWS Secrets Manager para dados sensíveis
- Revise Security Groups antes de aplicar

### Boas Práticas
- Execute `terraform fmt` antes de commitar
- Execute `terraform validate` para verificar sintaxe
- Use `terraform plan` antes de `apply`
- Documente mudanças significativas
- Mantenha estado remoto para projetos reais

## 📚 Recursos Adicionais

### Documentação
- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Language](https://www.terraform.io/language)
- [AWS Free Tier](https://aws.amazon.com/free/)

### Livros
- "Terraform: Up and Running" - Yevgeniy Brikman
- "Terraform Best Practices" - Yevgeniy Brikman

### Tutoriais
- [HashiCorp Learn - Terraform](https://learn.hashicorp.com/terraform)
- [AWS Terraform Tutorials](https://aws.amazon.com/getting-started/hands-on/)

## 🎓 Checklist de Conclusão

Ao finalizar este módulo, você deve ser capaz de:

- [ ] Criar recursos AWS básicos com Terraform
- [ ] Usar variáveis e outputs efetivamente
- [ ] Gerenciar estado local e remoto
- [ ] Organizar código em estrutura adequada
- [ ] Criar módulos reutilizáveis
- [ ] Implementar loops e condicionais
- [ ] Realizar deploys seguros

## 🚀 Próximos Passos

Após dominar os fundamentos, avance para:

1. **02-modules/** - Aprofundar em módulos profissionais
2. **04-best-practices/** - Padrões e convenções
3. **03-architectures/** - Arquiteturas completas

---

**Dica**: Não tenha pressa! Certifique-se de entender cada conceito antes de avançar.
