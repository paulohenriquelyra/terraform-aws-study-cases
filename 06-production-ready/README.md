# 06 - Production-Ready e CI/CD

Este diretório contém exemplos de infraestrutura production-ready com pipelines de CI/CD completos, demonstrando como automatizar o provisionamento e gerenciamento de recursos AWS usando Terraform.

## 📚 Conteúdo

Os exemplos neste diretório focam em workflows completos de produção, incluindo automação, testes, segurança e observabilidade.

### Estrutura de Aprendizado

```
06-production-ready/
├── 01-eks-github-actions/       # EKS com GitHub Actions
├── 02-jenkins-pipeline/         # Infraestrutura multi-cliente com Jenkins
├── 03-gitlab-ci/                # (Futuro) GitLab CI/CD
└── README.md                    # Este arquivo
```

## 🎯 Objetivos de Aprendizado

Ao completar os exemplos deste diretório, você será capaz de:

- ✅ Implementar pipelines CI/CD completos para Terraform
- ✅ Automatizar provisionamento de infraestrutura complexa
- ✅ Integrar testes de segurança e validação
- ✅ Gerenciar múltiplos ambientes (dev, staging, prod)
- ✅ Implementar estratégias de deployment seguro
- ✅ Configurar remote state e locking
- ✅ Monitorar e observar infraestrutura
- ✅ Implementar cost optimization
- ✅ Gerenciar secrets e credenciais de forma segura

## 📖 Ordem Recomendada de Estudo

### Pré-requisitos

Antes de começar este módulo, você deve ter completado:

1. ✅ **01-fundamentals** - Conceitos básicos de Terraform
2. ✅ **02-modules** - Estrutura e criação de módulos
3. ✅ **04-best-practices** - Padrões e convenções
4. ✅ Estudado **terraform-aws-modules/terraform-aws-vpc**
5. ✅ Estudado **terraform-aws-modules/terraform-aws-eks**

### Semana 1: EKS com GitHub Actions

**Projeto**: 01-eks-github-actions

**Foco**:
- Provisionamento completo de cluster EKS
- Automação com GitHub Actions
- Workflow dispatch e múltiplos ambientes
- Remote state com S3 e DynamoDB
- Node groups (On-Demand + Spot)

**Atividades**:
1. Estudar o projeto original
2. Reproduzir a infraestrutura
3. Entender o workflow do GitHub Actions
4. Implementar melhorias sugeridas
5. Documentar aprendizados

### Semana 2: Jenkins Pipeline

**Projeto**: 02-jenkins-pipeline (DhruvinSoni30)

**Foco**:
- Infraestrutura multi-cliente
- Automação com Jenkins
- Integração Terraform + Puppet
- Pipelines de build e destroy

**Atividades**:
1. Comparar com abordagem GitHub Actions
2. Entender padrão multi-cliente
3. Estudar integração com config management
4. Implementar pipeline próprio

### Semana 3-4: Projeto Integrado

**Objetivo**: Criar projeto próprio combinando aprendizados

**Requisitos**:
- Infraestrutura EKS completa
- Pipeline CI/CD (GitHub Actions ou Jenkins)
- Múltiplos ambientes (dev, staging, prod)
- Testes automatizados (tfsec, checkov)
- Monitoring e alertas
- Cost optimization
- Documentação completa

## 🛠️ Pré-requisitos Técnicos

### Ferramentas Necessárias

- ✅ Terraform >= 1.0
- ✅ AWS CLI configurado
- ✅ kubectl instalado
- ✅ Conta GitHub (para GitHub Actions)
- ✅ Jenkins (para pipeline Jenkins) - opcional
- ✅ Docker (para testes locais)

### Ferramentas de Validação

```bash
# Instalar tfsec
curl -s https://raw.githubusercontent.com/aquasecurity/tfsec/master/scripts/install_linux.sh | bash

# Instalar checkov
pip3 install checkov

# Instalar terraform-compliance
pip3 install terraform-compliance

# Instalar infracost
curl -fsSL https://raw.githubusercontent.com/infracost/infracost/master/scripts/install.sh | sh
```

### Configuração de Secrets

Para GitHub Actions, configure os seguintes secrets no repositório:

```bash
# AWS Credentials
AWS_ACCESS_KEY_ID
AWS_SECRET_ACCESS_KEY

# Opcionais
SLACK_WEBHOOK_URL          # Para notificações
INFRACOST_API_KEY         # Para análise de custos
```

## 📝 Estrutura Padrão de Cada Projeto

Cada projeto neste diretório segue uma estrutura consistente:

```
projeto/
├── original/                    # Código original do projeto de referência
│   └── (código do projeto)
├── improved/                    # Versão melhorada com boas práticas
│   ├── .github/workflows/       # Workflows CI/CD
│   ├── environments/            # Configurações por ambiente
│   │   ├── dev/
│   │   ├── staging/
│   │   └── prod/
│   ├── modules/                 # Módulos Terraform
│   ├── tests/                   # Testes automatizados
│   ├── docs/                    # Documentação adicional
│   └── README.md
├── notes/                       # Anotações de estudo
│   ├── architecture.md          # Análise da arquitetura
│   ├── learnings.md             # Aprendizados principais
│   ├── improvements.md          # Melhorias implementadas
│   └── troubleshooting.md       # Problemas e soluções
└── README.md                    # Documentação do projeto
```

## 💡 Conceitos-Chave por Projeto

### 01-eks-github-actions

**Conceitos**:
- GitHub Actions workflows
- Workflow dispatch manual
- Matrix strategy para múltiplos ambientes
- Terraform caching
- AWS credentials em GitHub Secrets
- EKS cluster provisioning
- Node groups (On-Demand + Spot)
- OIDC provider para IAM
- EKS add-ons
- Remote state com S3 + DynamoDB

**Arquitetura**:
- VPC dedicada com 3 AZs
- Subnets públicas e privadas
- NAT Gateway e Internet Gateway
- Security Groups
- EKS cluster com RBAC
- Mixed node groups

### 02-jenkins-pipeline

**Conceitos**:
- Jenkins pipelines (Jenkinsfile)
- Infraestrutura multi-cliente
- Terraform modules
- Puppet integration
- Build e destroy pipelines
- Infrastructure as Code + Config Management

**Arquitetura**:
- Master node
- Stack definitions
- Client-specific configurations
- Automated provisioning

## ⚠️ Avisos Importantes

### Custos AWS

Os projetos neste diretório provisionam recursos que **podem gerar custos significativos**:

- **EKS Cluster**: ~$0.10/hora (~$73/mês)
- **NAT Gateway**: ~$0.045/hora (~$32/mês)
- **EC2 Instances** (node groups): Variável conforme tipo e quantidade
- **EBS Volumes**: ~$0.10/GB/mês
- **Data Transfer**: Variável

**⚠️ IMPORTANTE**:
- Configure **alertas de billing** antes de começar
- Use **t3.medium** ou menor para node groups
- Minimize número de nodes (1-2 para estudos)
- **SEMPRE execute `terraform destroy`** após estudos
- Considere usar **AWS Free Tier** quando possível
- Use **Spot Instances** para reduzir custos

### Segurança

- **NUNCA** commite credenciais AWS
- Use **GitHub Secrets** ou **Jenkins Credentials**
- Configure **IAM roles** com least privilege
- Revise **Security Groups** antes de aplicar
- Implemente **tfsec** e **checkov** nos pipelines
- Use **OIDC** em vez de access keys quando possível
- Habilite **CloudTrail** para auditoria

### Boas Práticas de CI/CD

- Execute `terraform plan` antes de `apply`
- Implemente **approval gates** para produção
- Use **environments** no GitHub Actions
- Configure **branch protection** rules
- Implemente **automated testing**
- Documente **rollback procedures**
- Configure **notifications** (Slack, email)
- Mantenha **logs** de todas as execuções

## 📚 Recursos Adicionais

### Documentação

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Jenkins Pipeline Documentation](https://www.jenkins.io/doc/book/pipeline/)
- [EKS Best Practices](https://aws.github.io/aws-eks-best-practices/)
- [Terraform Cloud](https://www.terraform.io/cloud)
- [AWS CodePipeline](https://aws.amazon.com/codepipeline/)

### Ferramentas de CI/CD

- [GitHub Actions](https://github.com/features/actions)
- [Jenkins](https://www.jenkins.io/)
- [GitLab CI](https://docs.gitlab.com/ee/ci/)
- [CircleCI](https://circleci.com/)
- [Terraform Cloud](https://www.terraform.io/cloud)
- [Atlantis](https://www.runatlantis.io/)

### Ferramentas de Validação

- [tfsec](https://github.com/aquasecurity/tfsec) - Security scanner
- [checkov](https://www.checkov.io/) - Policy as code
- [terraform-compliance](https://terraform-compliance.com/) - BDD testing
- [infracost](https://www.infracost.io/) - Cost estimation
- [terrascan](https://github.com/tenable/terrascan) - Security scanner

### Tutoriais

- [Automating Terraform with GitHub Actions](https://learn.hashicorp.com/tutorials/terraform/github-actions)
- [EKS Workshop](https://www.eksworkshop.com/)
- [Terraform CI/CD Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)

## 🎓 Checklist de Conclusão

Ao finalizar este módulo, você deve ser capaz de:

- [ ] Criar pipelines CI/CD completos para Terraform
- [ ] Provisionar clusters EKS production-ready
- [ ] Implementar múltiplos ambientes (dev/staging/prod)
- [ ] Configurar remote state e locking
- [ ] Integrar testes de segurança (tfsec, checkov)
- [ ] Implementar cost optimization
- [ ] Gerenciar secrets de forma segura
- [ ] Configurar monitoring e alertas
- [ ] Documentar infraestrutura e processos
- [ ] Realizar rollback de mudanças
- [ ] Implementar approval gates
- [ ] Configurar notificações

## 🚀 Projeto Final

Após completar todos os exemplos, crie um **projeto integrado** que demonstre:

1. **Infraestrutura Completa**:
   - EKS cluster production-ready
   - VPC com múltiplas AZs
   - RDS para banco de dados
   - ElastiCache para cache
   - CloudFront para CDN
   - Route53 para DNS

2. **Pipeline CI/CD**:
   - GitHub Actions ou Jenkins
   - Múltiplos ambientes
   - Testes automatizados
   - Security scanning
   - Cost estimation
   - Approval gates

3. **Observabilidade**:
   - CloudWatch logs e metrics
   - Prometheus + Grafana
   - Alertas configurados
   - Dashboards

4. **Documentação**:
   - README completo
   - Diagramas de arquitetura
   - Runbooks
   - Troubleshooting guide

## 🤝 Contribuindo

Este é um repositório de estudos pessoais, mas melhorias são bem-vindas:

1. Fork o projeto
2. Crie uma branch para sua feature
3. Commit suas mudanças
4. Push para a branch
5. Abra um Pull Request

---

**Dica**: Este é o módulo mais avançado. Não tenha pressa e certifique-se de dominar os conceitos anteriores antes de começar. A prática leva à perfeição!

**Próximo passo**: Comece com `01-eks-github-actions/` e siga o roteiro de estudos.
