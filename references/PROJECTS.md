# Projetos de Referência - Terraform AWS

Este documento lista todos os projetos de referência utilizados neste repositório de estudos, com análise detalhada de cada um.

## 📊 Resumo Executivo

| Projeto | Stars | Categoria | Nível | Prioridade |
|---------|-------|-----------|-------|------------|
| terraform-aws-modules (org) | 4.8k (EKS) | Módulos | Intermediário | ⭐⭐⭐⭐⭐ |
| shuaibiyy/awesome-tf | 6.2k | Referência | Todos | ⭐⭐⭐⭐⭐ |
| futurice/terraform-examples | 839 | Exemplos | Intermediário | ⭐⭐⭐⭐ |
| cloudposse/terraform-aws-components | 534 | Enterprise | Avançado | ⭐⭐⭐⭐ |
| alfonsof/terraform-aws-examples | 138 | Fundamentos | Iniciante | ⭐⭐⭐⭐⭐ |
| aws-samples/best-practices | 52 | Guidelines | Intermediário | ⭐⭐⭐⭐⭐ |
| YashPimple/Terraform-AWS-Architecture | 16 | Arquiteturas | Intermediário | ⭐⭐⭐ |
| KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions | 2 | CI/CD | Avançado | ⭐⭐⭐⭐ |
| DhruvinSoni30/Infrastructure_Provisioning | 4 | Production | Avançado | ⭐⭐⭐ |

---

## 1. alfonsof/terraform-aws-examples

### Informações Gerais
- **URL**: https://github.com/alfonsof/terraform-aws-examples
- **Stars**: 138 | **Forks**: 199
- **Licença**: MIT
- **Linguagem**: HCL 98.6%, Shell 1.4%
- **Última atualização**: Ativo

### Descrição
Exemplos de Terraform baseados no livro "Terraform: Up and Running" de Yevgeniy Brikman. Oferece progressão didática de 14 exemplos, do básico ao avançado.

### Conteúdo Principal
1. **Hello World** - Deploy de servidor único (script mínimo)
2. **One Server** - Deploy de servidor único completo
3. **One Webserver** - Servidor web retornando "Hello, World"
4. **One Webserver with vars** - Servidor web com variáveis
5. **Cluster Webserver** - Cluster com Auto Scaling e ELB
6. **Create S3** - Criação de bucket S3
7. **Terraform State** - Gerenciamento de estado
8. **File Layout** - Estrutura de arquivos
9. **Module Example** - Uso de módulos
10. **Multi Repo Example** - Módulos em múltiplos repositórios
11. **Loops Example** - Uso de loops
12. **If-Statements Example** - Condicionais
13. **If-Else-Statements Example** - Condicionais simples
14. **Zero-Downtime Deployment** - Deploy sem downtime

### Por Que Estudar
- ✅ Progressão didática clara e estruturada
- ✅ Baseado em livro referência da indústria
- ✅ Exemplos práticos e incrementais
- ✅ Boa documentação
- ✅ Ideal para iniciantes

### Aplicação Prática
- Fundamentos de Terraform
- Conceitos de infraestrutura básica AWS
- Padrões de organização de código
- State management

### Prioridade de Estudo
⭐⭐⭐⭐⭐ **ALTA** - Começar por aqui

---

## 2. terraform-aws-modules (Organização GitHub)

### Informações Gerais
- **URL**: https://github.com/terraform-aws-modules
- **Repositórios**: 61
- **Seguidores**: 4k
- **Registry**: https://registry.terraform.io/namespaces/terraform-aws-modules
- **Licença**: Apache-2.0

### Descrição
Coleção oficial de módulos Terraform AWS suportados pela comunidade. Cada serviço AWS tem seu próprio repositório com módulo especializado.

### Módulos Principais

| Módulo | Stars | Descrição | Uso |
|--------|-------|-----------|-----|
| terraform-aws-vpc | 3.2k | VPC resources | Networking fundamental |
| terraform-aws-eks | 4.8k | EKS cluster | Kubernetes na AWS |
| terraform-aws-rds | 935 | RDS databases | Bancos de dados |
| terraform-aws-iam | 847 | IAM resources | Segurança e permissões |
| terraform-aws-lambda | 1k | Lambda functions | Serverless |
| terraform-aws-ecs | 635 | ECS resources | Containers |
| terraform-aws-alb | 455 | Load balancers | Balanceamento |
| terraform-aws-route53 | 143 | DNS management | DNS |

### Por Que Estudar
- ✅ Padrão de mercado para módulos AWS
- ✅ Código production-ready
- ✅ Publicados no Terraform Registry
- ✅ Manutenção ativa
- ✅ Documentação completa
- ✅ Exemplos de uso incluídos

### Aplicação Prática
- Estrutura profissional de módulos
- Padrões de versionamento
- Documentação automática
- Testes de módulos
- Publicação no Registry

### Prioridade de Estudo
⭐⭐⭐⭐⭐ **ALTA** - Estudar VPC e EKS em profundidade

---

## 3. cloudposse/terraform-aws-components

### Informações Gerais
- **URL**: https://github.com/cloudposse/terraform-aws-components
- **Stars**: 534 | **Forks**: 225
- **Licença**: Apache-2.0
- **Status**: Migrado para repositórios individuais

### Descrição
Módulos Terraform root auto-contidos e opinativos de nível enterprise. Cada componente resolve um problema específico com abordagem completa.

### Componentes Principais
- **Account Management**: account, account-map, account-settings
- **Networking**: VPC, DNS, ALB, API Gateway, Transit Gateway
- **Compute**: EC2, ECS, EKS (20+ add-ons)
- **Storage**: S3, EFS, DynamoDB, ElastiCache, RDS Aurora
- **Security**: IAM, Config, CloudTrail, Inspector, Shield, SSO
- **Monitoring**: CloudWatch, Datadog integration
- **Kubernetes**: ArgoCD, Karpenter, cert-manager, external-dns
- **CI/CD**: GitHub Actions runners, Spacelift

### Por Que Estudar
- ✅ Arquitetura enterprise-grade
- ✅ Forte foco em EKS e Kubernetes
- ✅ Padrões opinativos (opinionated)
- ✅ Componentes completos e integrados
- ✅ Mantido por empresa especializada (Cloud Posse)

### Aplicação Prática
- Arquiteturas enterprise
- Integração de múltiplos serviços
- Padrões de organização complexos
- EKS em produção

### Prioridade de Estudo
⭐⭐⭐⭐ **MÉDIA-ALTA** - Após dominar fundamentos

---

## 4. aws-samples/aws-terraform-best-practices

### Informações Gerais
- **URL**: https://github.com/aws-samples/aws-terraform-best-practices
- **Stars**: 52 | **Forks**: 11
- **Licença**: MIT-0
- **Fonte**: AWS Samples (oficial)

### Descrição
Repositório oficial da AWS com best practices e formas acordadas de trabalhar efetivamente em equipe com Terraform.

### Conteúdo Principal
- **General Guidelines**: Diretrizes gerais de desenvolvimento
- **Terraform Guidelines**: 
  - Version management (tfenv)
  - Standard module structure
  - Reusable module structure
  - Naming conventions
  - Stateful resources
  - Built-in formatting and validation
  - Expressions complexity
  - Conditional values, Iterated resources
  - Workspaces, Remote state
  - Default tags, Secrets
  - Pre-commit hooks
  - Infrastructure testing
- **Module Creation**: Source repository, Terraform Registry
- **Backend Configuration**: S3, Terraform Cloud/Enterprise
- **Security Guidelines**

### Por Que Estudar
- ✅ Repositório oficial AWS
- ✅ Foco em padrões de equipe
- ✅ Guidelines de segurança
- ✅ Orientações sobre testes
- ✅ Best practices documentadas

### Aplicação Prática
- Padrões de organização de equipe
- Estrutura de projetos
- Convenções de nomenclatura
- Segurança e compliance
- Testes de infraestrutura

### Prioridade de Estudo
⭐⭐⭐⭐⭐ **ALTA** - Essencial para trabalho profissional

---

## 5. YashPimple/Terraform-AWS-Architecture

### Informações Gerais
- **URL**: https://github.com/YashPimple/Terraform-AWS-Architecture
- **Stars**: 16 | **Forks**: 8
- **Licença**: MIT
- **Linguagens**: HCL 81%, JavaScript 13.3%, HTML 2.8%

### Descrição
Implementação de arquiteturas escaláveis e resilientes na AWS. Demonstra padrões arquiteturais comuns com aplicações de exemplo.

### Arquiteturas Implementadas
1. **2-Tier Architecture**: Web tier + Database tier (EC2, LB, RDS)
2. **3-Tier Architecture**: Web + Application + Database tiers (EC2, ASG, LB, RDS)
3. **3-Tier-EKS-Architecture**: Arquitetura 3-tier com EKS
4. **EKS-Cluster**: Infraestrutura para cluster EKS

### Por Que Estudar
- ✅ Exemplos de arquiteturas completas
- ✅ Padrões arquiteturais comuns (2-tier, 3-tier)
- ✅ Inclui aplicações de exemplo
- ✅ Estrutura organizada por arquitetura

### Aplicação Prática
- Padrões arquiteturais
- Arquiteturas multi-tier
- Integração de componentes
- Aplicações reais

### Prioridade de Estudo
⭐⭐⭐ **MÉDIA** - Após fundamentos e módulos

---

## 6. futurice/terraform-examples

### Informações Gerais
- **URL**: https://github.com/futurice/terraform-examples
- **Stars**: 839 | **Forks**: 564
- **Licença**: MIT
- **Linguagens**: HCL 85.6%, JavaScript 10.4%, Shell 3.0%
- **Empresa**: Futurice (consultoria)

### Descrição
Exemplos de Terraform para todas as principais clouds (AWS, Azure, Google Cloud) prontos para copiar e colar. Foco em casos de uso reais.

### Exemplos AWS
- **aws_domain_redirect**: Redirecionamento de domínio
- **aws_ec2_ebs_docker_host**: Host Docker com EC2 e EBS
- **aws_lambda_api**: API com Lambda e API Gateway
- **aws_lambda_cronjob**: Cronjob com Lambda e CloudWatch
- **aws_mailgun_domain**: Configuração de domínio Mailgun
- **aws_reverse_proxy**: Reverse proxy com CloudFront

### Casos de Uso Destacados
- WordPress on Fargate
- Minecraft server low-cost
- Identity Aware Proxy (BeyondCorp style)
- Serverless Camunda Workflow Engine

### Por Que Estudar
- ✅ Multi-cloud (AWS, Azure, GCP)
- ✅ Exemplos práticos prontos para uso
- ✅ Empresa de consultoria estabelecida
- ✅ Casos de uso reais
- ✅ Boa documentação inline

### Aplicação Prática
- Casos de uso específicos
- Padrões multi-cloud
- Soluções prontas para adaptar
- Serverless patterns

### Prioridade de Estudo
⭐⭐⭐⭐ **MÉDIA-ALTA** - Excelente para casos práticos

---

## 7. shuaibiyy/awesome-tf

### Informações Gerais
- **URL**: https://github.com/shuaibiyy/awesome-tf
- **Stars**: 6.2k | **Forks**: 946
- **Licença**: CC0-1.0
- **Contribuidores**: 169
- **Tipo**: Lista curada (não contém código)

### Descrição
Lista curada de recursos sobre Terraform e OpenTofu da HashiCorp. Referência essencial para descobrir projetos, ferramentas e recursos.

### Conteúdo
- Módulos AWS oficiais e da comunidade
- Ferramentas complementares
- Tutoriais e cursos
- Livros e documentação
- Providers
- Testing frameworks
- CI/CD integrations

### Por Que Estudar
- ✅ Referência comunitária com 6.2k stars
- ✅ 169 contribuidores ativos
- ✅ Descoberta de projetos e ferramentas
- ✅ Recursos educacionais
- ✅ Atualizado regularmente

### Aplicação Prática
- Descoberta de recursos
- Seleção de ferramentas
- Referência de módulos
- Aprendizado contínuo

### Prioridade de Estudo
⭐⭐⭐⭐⭐ **ALTA** - Consultar regularmente

---

## 8. KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions

### Informações Gerais
- **URL**: https://github.com/KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions
- **Stars**: 2 | **Forks**: 7
- **Linguagens**: HCL 100%
- **Blog**: [Production-Ready EKS Provisioning](https://kunalmaurya.hashnode.dev/production-ready-eks-provisioning-with-terraform-and-github-actions)

### Descrição
Provisionamento de cluster EKS production-grade usando Terraform com automação completa via GitHub Actions. Demonstra workflow moderno de CI/CD.

### Estrutura
- **backend/**: Backend S3 + DynamoDB
- **eks/**: Configuração principal
- **module/**: Módulo com VPC, IAM e EKS
- **.github/workflows/**: Workflow GitHub Actions

### Abordagem
- Cluster EKS com VPC dedicada (3 AZs)
- Node groups (On-Demand + Spot)
- OIDC provider para IAM
- EKS add-ons gerenciados
- Workflow dispatch manual (plan/apply/destroy)
- Terraform caching
- Validação automática

### Por Que Estudar
- ✅ EKS + GitHub Actions (lacuna nos outros projetos)
- ✅ Arquitetura production-ready
- ✅ Código limpo e bem estruturado
- ✅ Workflow moderno de CI/CD
- ✅ Relevante para mercado (EKS + CI/CD muito demandado)
- ✅ Uso de Spot instances para otimização

### Aplicação Prática
- Provisionamento de EKS
- Automação com GitHub Actions
- Remote state management
- Cost optimization com Spot
- Workflow dispatch

### Prioridade de Estudo
⭐⭐⭐⭐ **MÉDIA-ALTA** - Após dominar EKS e fundamentos de CI/CD

### Pontos de Atenção
- Repositório recente (baixa popularidade)
- Documentação básica
- Módulo monolítico (VPC + IAM + EKS)
- Falta de testes automatizados
- Security group com 0.0.0.0/0

### Melhorias Sugeridas
- Separar módulos (VPC, IAM, EKS)
- Adicionar tfsec e checkov
- Implementar múltiplos ambientes
- Adicionar Infracost
- Melhorar security groups
- Adicionar observabilidade

---

## 9. DhruvinSoni30/Terraform_Infrastructure_Provisioning

### Informações Gerais
- **URL**: https://github.com/DhruvinSoni30/Terraform_Infrastructure_Provisioning
- **Stars**: 4 | **Forks**: 5
- **Linguagens**: HCL 55.9%, Shell 21.6%, Puppet 17.2%, Python 5.3%

### Descrição
Infraestrutura production-ready altamente disponível na AWS usando Terraform Modules & Jenkins. Demonstra workflow completo de CI/CD.

### Estrutura
- **Infrastructure_Definition**: Infraestrutura base
- **Master_Definition**: Nó master
- **Stack_Definition**: Stacks para clientes
- **puppet_configs**: Configurações Puppet
- **Jenkinsfiles**: Pipelines CI/CD
- **GitHub Workflows**: Automação

### Abordagem
- Infraestrutura multi-cliente usando módulos
- Automação completa com Jenkins
- Apenas criar diretório com terraform.tfvars
- Integração com Puppet
- Pipelines separados para build e destroy

### Por Que Estudar
- ✅ Exemplo production-ready
- ✅ Uso de módulos reutilizáveis
- ✅ Integração CI/CD com Jenkins
- ✅ Estrutura multi-cliente
- ✅ Workflow documentado
- ✅ Combina IaC + Config Management

### Aplicação Prática
- CI/CD com Terraform
- Infraestrutura multi-tenant
- Automação completa
- Integration patterns

### Prioridade de Estudo
⭐⭐⭐ **MÉDIA** - Após dominar CI/CD básico

---

## 📈 Ordem Recomendada de Estudo

### Iniciante → Intermediário
1. **alfonsof/terraform-aws-examples** - Fundamentos
2. **aws-samples/aws-terraform-best-practices** - Padrões
3. **terraform-aws-modules/terraform-aws-vpc** - Módulo essencial
4. **terraform-aws-modules/terraform-aws-eks** - Kubernetes

### Intermediário → Avançado
5. **YashPimple/Terraform-AWS-Architecture** - Arquiteturas
6. **futurice/terraform-examples** - Casos de uso
7. **cloudposse/terraform-aws-components** - Enterprise
8. **KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions** - EKS + GitHub Actions
9. **DhruvinSoni30/Infrastructure_Provisioning** - Production + Jenkins

### Referência Contínua
- **shuaibiyy/awesome-tf** - Consultar sempre que precisar descobrir novos recursos

---

## 🎯 Projetos Prioritários para Portfolio

Para demonstrar competência profissional em entrevistas:

1. **terraform-aws-modules/terraform-aws-vpc** ⭐⭐⭐⭐⭐
   - Networking é fundamental em qualquer infraestrutura

2. **terraform-aws-modules/terraform-aws-eks** ⭐⭐⭐⭐⭐
   - Kubernetes/EKS é altamente demandado no mercado

3. **aws-samples/aws-terraform-best-practices** ⭐⭐⭐⭐⭐
   - Demonstra conhecimento de padrões profissionais

4. **KUNAL-MAURYA1470/EKS-Terraform-GitHub-Actions** ⭐⭐⭐⭐
   - Mostra domínio de CI/CD moderno com GitHub Actions

5. **cloudposse/terraform-aws-components** ⭐⭐⭐⭐
   - Mostra conhecimento de arquiteturas enterprise

6. **futurice/terraform-examples** ⭐⭐⭐⭐
   - Demonstra versatilidade com casos de uso variados

---

**Última atualização**: Outubro 2025
