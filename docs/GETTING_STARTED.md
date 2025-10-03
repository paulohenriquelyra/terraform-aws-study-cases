# Guia de Início Rápido

Este guia ajudará você a configurar seu ambiente e começar os estudos de Terraform na AWS.

## 📋 Pré-requisitos

### 1. Instalar Terraform

#### Usando tfenv (recomendado)
```bash
# Instalar tfenv
git clone https://github.com/tfutils/tfenv.git ~/.tfenv
echo 'export PATH="$HOME/.tfenv/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Instalar versão mais recente do Terraform
tfenv install latest
tfenv use latest

# Verificar instalação
terraform version
```

#### Download direto
```bash
# Linux
wget https://releases.hashicorp.com/terraform/1.6.0/terraform_1.6.0_linux_amd64.zip
unzip terraform_1.6.0_linux_amd64.zip
sudo mv terraform /usr/local/bin/
terraform version
```

### 2. Instalar e Configurar AWS CLI

```bash
# Instalar AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

# Verificar instalação
aws --version

# Configurar credenciais
aws configure
# AWS Access Key ID: [sua access key]
# AWS Secret Access Key: [sua secret key]
# Default region name: us-east-1
# Default output format: json
```

### 3. Configurar Editor (VS Code)

```bash
# Instalar extensões recomendadas
code --install-extension hashicorp.terraform
code --install-extension ms-vscode.vscode-json
code --install-extension redhat.vscode-yaml
```

Configurações recomendadas (`.vscode/settings.json`):
```json
{
  "terraform.experimentalFeatures.validateOnSave": true,
  "terraform.languageServer.enable": true,
  "files.associations": {
    "*.tf": "terraform",
    "*.tfvars": "terraform"
  },
  "editor.formatOnSave": true
}
```

### 4. Instalar Ferramentas Auxiliares

```bash
# tflint - Linter para Terraform
curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# terraform-docs - Geração automática de documentação
curl -Lo ./terraform-docs.tar.gz https://github.com/terraform-docs/terraform-docs/releases/download/v0.16.0/terraform-docs-v0.16.0-linux-amd64.tar.gz
tar -xzf terraform-docs.tar.gz
sudo mv terraform-docs /usr/local/bin/

# pre-commit - Git hooks
pip install pre-commit
```

## 🚀 Primeiro Exemplo

### 1. Criar Estrutura Básica

```bash
mkdir -p ~/terraform-studies/01-hello-world
cd ~/terraform-studies/01-hello-world
```

### 2. Criar Arquivo `main.tf`

```hcl
# main.tf
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name = "terraform-example"
  }
}
```

### 3. Executar Comandos Terraform

```bash
# Inicializar diretório (baixar providers)
terraform init

# Validar sintaxe
terraform validate

# Formatar código
terraform fmt

# Ver plano de execução
terraform plan

# Aplicar mudanças (criar recursos)
terraform apply

# Destruir recursos
terraform destroy
```

## 📚 Workflow Básico de Estudo

### Para Cada Exemplo

1. **Ler a documentação** do exemplo
2. **Analisar o código** linha por linha
3. **Executar** `terraform plan` e entender o output
4. **Aplicar** as mudanças com `terraform apply`
5. **Verificar** os recursos criados no Console AWS
6. **Experimentar** modificações no código
7. **Documentar** aprendizados em notas
8. **Destruir** recursos com `terraform destroy`

### Comandos Essenciais

```bash
# Inicializar projeto
terraform init

# Validar configuração
terraform validate

# Formatar código
terraform fmt

# Planejar mudanças
terraform plan

# Aplicar mudanças
terraform apply

# Aplicar sem confirmação
terraform apply -auto-approve

# Destruir recursos
terraform destroy

# Ver estado atual
terraform show

# Listar recursos no estado
terraform state list

# Ver output values
terraform output

# Atualizar providers
terraform init -upgrade
```

## 🔒 Boas Práticas Desde o Início

### 1. Sempre Use Versionamento

```hcl
terraform {
  required_version = ">= 1.0"
  
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
```

### 2. Use Variáveis

```hcl
# variables.tf
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

# main.tf
resource "aws_instance" "example" {
  instance_type = var.instance_type
}
```

### 3. Use Outputs

```hcl
# outputs.tf
output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.example.id
}
```

### 4. Organize Arquivos

```
project/
├── main.tf           # Recursos principais
├── variables.tf      # Declaração de variáveis
├── outputs.tf        # Declaração de outputs
├── terraform.tfvars  # Valores das variáveis
└── README.md         # Documentação
```

### 5. Use .gitignore

```bash
# .gitignore
.terraform/
*.tfstate
*.tfstate.backup
.terraform.lock.hcl
terraform.tfvars
*.tfvars
```

## 💰 Gerenciamento de Custos AWS

### Free Tier
- EC2: 750 horas/mês de t2.micro
- S3: 5GB de armazenamento
- RDS: 750 horas/mês de db.t2.micro
- Lambda: 1 milhão de requisições gratuitas

### Dicas para Economizar
1. **Sempre destrua recursos** após estudos: `terraform destroy`
2. **Use t2.micro** para EC2 (Free Tier)
3. **Configure alertas** de billing no AWS Console
4. **Revise recursos** regularmente
5. **Use tags** para rastrear custos

### Configurar Alerta de Billing
```bash
# No AWS Console:
# 1. Ir para Billing Dashboard
# 2. Billing Preferences > Receive Billing Alerts
# 3. CloudWatch > Alarms > Create Alarm
# 4. Configurar threshold (ex: $5)
```

## 🐛 Troubleshooting Comum

### Erro: "No valid credential sources found"
```bash
# Verificar configuração AWS
aws configure list

# Reconfigurar
aws configure
```

### Erro: "Error locking state"
```bash
# Remover lock (cuidado!)
terraform force-unlock <LOCK_ID>
```

### Erro: "Provider version constraint"
```bash
# Atualizar providers
terraform init -upgrade
```

### Erro: "Resource already exists"
```bash
# Importar recurso existente
terraform import aws_instance.example i-1234567890abcdef0
```

## 📖 Próximos Passos

1. ✅ Configurar ambiente
2. ✅ Executar primeiro exemplo
3. 📚 Começar estudos em `01-fundamentals/`
4. 📝 Documentar aprendizados
5. 🔄 Seguir roteiro de estudos no README principal

## 🔗 Recursos Úteis

- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Docs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Registry](https://registry.terraform.io/)
- [AWS Free Tier](https://aws.amazon.com/free/)
- [Terraform Best Practices](https://www.terraform-best-practices.com/)

---

**Dúvidas?** Consulte a documentação oficial ou abra uma issue neste repositório.
