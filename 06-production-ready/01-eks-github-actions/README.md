# EKS com GitHub Actions - Estudo de Caso

Este diretório contém o estudo do projeto [KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions](https://github.com/KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions), que demonstra o provisionamento de um cluster Amazon EKS production-grade usando Terraform com automação via GitHub Actions.

## 📋 Sobre o Projeto

O projeto implementa uma arquitetura completa de EKS com:
- VPC dedicada com subnets públicas e privadas em 3 AZs
- NAT Gateway e Internet Gateway
- Cluster EKS com OIDC provider
- Node groups com On-Demand e Spot instances
- EKS add-ons gerenciados
- Remote state com S3 e DynamoDB
- Automação completa via GitHub Actions

## 🎯 Objetivos de Aprendizado

Ao estudar este projeto, você aprenderá:

1. **Provisionamento de EKS**: Como criar um cluster EKS production-ready com Terraform
2. **Arquitetura de Rede**: VPC, subnets, NAT Gateway, Internet Gateway, Security Groups
3. **Node Groups**: Configuração de On-Demand e Spot instances para otimização de custos
4. **IAM e OIDC**: Roles, policies e OIDC provider para service accounts
5. **GitHub Actions**: Automação de workflows de Terraform (plan/apply/destroy)
6. **Remote State**: Configuração de backend S3 com DynamoDB para locking
7. **Modularização**: Estrutura de módulos reutilizáveis

## 📁 Estrutura do Diretório

```
01-eks-github-actions/
├── original/                    # Código original do projeto
│   ├── .github/workflows/       # Workflow GitHub Actions
│   ├── backend/                 # Backend S3 + DynamoDB
│   ├── eks/                     # Configuração do EKS
│   ├── module/                  # Módulo Terraform
│   └── README.md
├── improved/                    # Versão melhorada (a ser criada)
│   ├── .github/workflows/       # Workflows aprimorados
│   ├── environments/            # Múltiplos ambientes
│   ├── modules/                 # Módulos separados
│   ├── tests/                   # Testes automatizados
│   └── README.md
├── notes/                       # Anotações de estudo
│   ├── architecture.md          # Análise da arquitetura
│   ├── learnings.md             # Aprendizados principais
│   ├── improvements.md          # Melhorias implementadas
│   └── troubleshooting.md       # Problemas e soluções
└── README.md                    # Este arquivo
```

## 🚀 Como Começar

### Passo 1: Estudar o Projeto Original

1. **Clone o projeto original**:
   ```bash
   cd original/
   git clone https://github.com/KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions.git .
   ```

2. **Analise a estrutura**:
   - Leia o README.md
   - Estude o workflow em `.github/workflows/main.yml`
   - Analise os módulos Terraform
   - Revise as variáveis e configurações

3. **Leia o blog do autor**:
   - [Production-Ready EKS Provisioning with Terraform and GitHub Actions](https://kunalmaurya.hashnode.dev/production-ready-eks-provisioning-with-terraform-and-github-actions)

### Passo 2: Entender a Arquitetura

Estude o diagrama de arquitetura incluído no projeto e documente:

- **Componentes de Rede**: VPC, subnets, NAT, IGW
- **Componentes EKS**: Cluster, node groups, add-ons
- **Componentes IAM**: Roles para cluster e nodes, OIDC
- **Workflow CI/CD**: GitHub Actions, secrets, environments

Documente suas descobertas em `notes/architecture.md`.

### Passo 3: Reproduzir Localmente

**⚠️ ATENÇÃO**: Este projeto provisiona recursos que geram custos na AWS!

1. **Configure AWS CLI**:
   ```bash
   aws configure
   ```

2. **Crie o backend** (S3 + DynamoDB):
   ```bash
   cd original/backend/
   terraform init
   terraform plan
   terraform apply
   ```

3. **Configure o backend remoto**:
   - Atualize `eks/backend.tf` com os valores do backend criado

4. **Provisione o EKS**:
   ```bash
   cd original/eks/
   terraform init
   terraform plan
   terraform apply
   ```

5. **Configure kubectl**:
   ```bash
   aws eks update-kubeconfig --name <cluster-name> --region us-east-1
   kubectl get nodes
   ```

6. **Destrua os recursos**:
   ```bash
   terraform destroy
   cd ../backend/
   terraform destroy
   ```

### Passo 4: Configurar GitHub Actions

1. **Fork o projeto** para seu GitHub
2. **Configure Secrets**:
   - `AWS_ACCESS_KEY_ID`
   - `AWS_SECRET_ACCESS_KEY`
3. **Configure Environment** (opcional):
   - Crie environment "production" com proteções
4. **Execute o workflow**:
   - Actions → EKS-Creation-Using-Terraform → Run workflow
   - Selecione ação (plan/apply/destroy)

### Passo 5: Implementar Melhorias

Crie uma versão melhorada em `improved/` com:

1. **Módulos Separados**:
   - `modules/vpc/` - Networking
   - `modules/iam/` - IAM roles e policies
   - `modules/eks/` - Cluster EKS

2. **Múltiplos Ambientes**:
   - `environments/dev/`
   - `environments/staging/`
   - `environments/prod/`

3. **Testes Automatizados**:
   - tfsec para security scanning
   - checkov para policy validation
   - terraform-compliance para BDD testing

4. **Melhorias de Segurança**:
   - Security groups mais restritivos
   - IAM policies com least privilege
   - Secrets management adequado

5. **Observabilidade**:
   - CloudWatch logs e metrics
   - Dashboards
   - Alertas

6. **Cost Optimization**:
   - Infracost no workflow
   - Análise de custos por ambiente
   - Recomendações de otimização

Documente as melhorias em `notes/improvements.md`.

## 📊 Arquitetura do Projeto Original

### Componentes Principais

| Componente | Descrição | Recursos AWS |
|------------|-----------|--------------|
| **VPC** | Rede dedicada | VPC, Subnets (3 públicas + 3 privadas) |
| **Networking** | Conectividade | NAT Gateway, Internet Gateway, Route Tables |
| **EKS Cluster** | Kubernetes gerenciado | EKS Cluster, OIDC Provider |
| **Node Groups** | Workers | On-Demand + Spot instances |
| **IAM** | Permissões | Roles para cluster e nodes |
| **Add-ons** | Componentes EKS | vpc-cni, kube-proxy, coredns |
| **Backend** | State management | S3 bucket, DynamoDB table |

### Workflow GitHub Actions

```
Trigger (workflow_dispatch)
    ↓
Checkout code
    ↓
Setup Terraform
    ↓
Cache Terraform
    ↓
Terraform Init
    ↓
Terraform Format Check
    ↓
Terraform Validate
    ↓
Terraform Plan/Apply/Destroy
```

## 💡 Principais Aprendizados

### 1. Estrutura Modular

O projeto demonstra uma boa separação de responsabilidades:
- **backend/**: Provisionamento do backend (S3 + DynamoDB)
- **eks/**: Configuração principal que chama o módulo
- **module/**: Módulo reutilizável com VPC, IAM e EKS

### 2. GitHub Actions Workflow

O workflow implementa:
- **Workflow dispatch manual**: Controle total sobre quando executar
- **Seleção de ação**: plan, apply ou destroy
- **Seleção de .tfvars**: Suporte a múltiplos ambientes
- **Caching**: Otimização de performance
- **Validação**: fmt check e validate antes de aplicar

### 3. Node Groups Mistos

Uso inteligente de On-Demand e Spot instances:
- **On-Demand**: Para workloads críticos
- **Spot**: Para workloads tolerantes a interrupções (até 90% de economia)

### 4. OIDC Provider

Implementação de OIDC para permitir que pods assumam IAM roles sem credenciais estáticas.

### 5. Remote State

Backend remoto com:
- **S3**: Armazenamento do state
- **DynamoDB**: Locking para prevenir conflitos

## ⚠️ Pontos de Atenção

### Custos

Recursos que geram custos significativos:
- EKS Cluster: ~$73/mês
- NAT Gateway: ~$32/mês
- EC2 Instances: Variável
- EBS Volumes: ~$0.10/GB/mês

**Total estimado**: $150-300/mês dependendo da configuração

### Segurança

Melhorias necessárias:
- Security Group com `0.0.0.0/0` deve ser restrito
- Implementar Network Policies no Kubernetes
- Adicionar scanning de vulnerabilidades
- Implementar Pod Security Standards

### Testes

O projeto original não inclui:
- Testes automatizados de infraestrutura
- Security scanning (tfsec, checkov)
- Cost estimation (Infracost)
- Drift detection

## 📚 Recursos Adicionais

### Documentação

- [EKS Best Practices Guide](https://aws.github.io/aws-eks-best-practices/)
- [Terraform AWS Provider - EKS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [EKS Workshop](https://www.eksworkshop.com/)

### Módulos Relacionados

- [terraform-aws-modules/eks](https://github.com/terraform-aws-modules/terraform-aws-eks)
- [terraform-aws-modules/vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc)

### Ferramentas

- [kubectl](https://kubernetes.io/docs/tasks/tools/)
- [eksctl](https://eksctl.io/)
- [k9s](https://k9scli.io/) - Terminal UI para Kubernetes
- [lens](https://k8slens.dev/) - Kubernetes IDE

## 🎓 Exercícios Práticos

### Exercício 1: Análise de Arquitetura
- Desenhe o diagrama de rede completo
- Identifique todos os recursos criados
- Calcule os custos estimados

### Exercício 2: Reprodução
- Provisione a infraestrutura
- Configure kubectl
- Deploy uma aplicação de exemplo
- Destrua os recursos

### Exercício 3: Melhorias de Segurança
- Implemente security groups mais restritivos
- Adicione tfsec ao workflow
- Configure Pod Security Standards
- Implemente Network Policies

### Exercício 4: Múltiplos Ambientes
- Crie configurações para dev/staging/prod
- Implemente workflow matrix
- Configure approval gates para prod

### Exercício 5: Observabilidade
- Configure CloudWatch Container Insights
- Crie dashboards no CloudWatch
- Configure alertas
- Implemente logging centralizado

## 📝 Checklist de Estudo

- [ ] Ler README e blog do autor
- [ ] Analisar estrutura do código
- [ ] Entender workflow GitHub Actions
- [ ] Estudar módulo VPC
- [ ] Estudar módulo IAM
- [ ] Estudar módulo EKS
- [ ] Reproduzir localmente (opcional, gera custos)
- [ ] Configurar GitHub Actions
- [ ] Documentar arquitetura em notes/
- [ ] Implementar melhorias em improved/
- [ ] Adicionar testes automatizados
- [ ] Criar múltiplos ambientes
- [ ] Implementar observabilidade
- [ ] Documentar aprendizados

## 🚀 Próximos Passos

Após completar este estudo:

1. Compare com o projeto **terraform-aws-modules/eks**
2. Estude o projeto **02-jenkins-pipeline**
3. Crie seu próprio projeto EKS integrado
4. Adicione ao seu portfólio no GitHub

---

**Tempo estimado de estudo**: 1-2 semanas

**Nível de dificuldade**: ⭐⭐⭐⭐ (Avançado)

**Pré-requisitos**: Fundamentos de Terraform, AWS, Kubernetes e CI/CD
