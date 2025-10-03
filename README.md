# Terraform AWS Study Cases

> Repositório profissional de estudos de caso de Terraform na AWS, organizado para aprendizado progressivo e preparação para o mercado de trabalho.

[![Terraform](https://img.shields.io/badge/Terraform-1.x-623CE4?logo=terraform)](https://www.terraform.io/)
[![AWS](https://img.shields.io/badge/AWS-Cloud-FF9900?logo=amazon-aws)](https://aws.amazon.com/)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)

## 📋 Sobre Este Repositório

Este repositório foi criado para organizar e documentar estudos práticos de **Infrastructure as Code (IaC)** usando **Terraform** na **Amazon Web Services (AWS)**. O objetivo é desenvolver competências profissionais através da análise, reprodução e evolução de projetos referenciados da comunidade.

## 🎯 Objetivos

- Dominar Terraform através de exemplos práticos e progressivos
- Compreender padrões e best practices da indústria
- Desenvolver arquiteturas escaláveis e resilientes na AWS
- Preparar-se para oportunidades profissionais na área de DevOps/Cloud
- Construir um portfólio técnico demonstrável

## 📚 Estrutura do Repositório

```
terraform-aws-study-cases/
├── 01-fundamentals/          # Conceitos fundamentais e exemplos básicos
├── 02-modules/               # Estrutura e desenvolvimento de módulos
├── 03-architectures/         # Arquiteturas completas (2-tier, 3-tier, etc.)
├── 04-best-practices/        # Padrões, convenções e guidelines
├── 05-real-world-cases/      # Casos de uso reais e práticos
├── 06-production-ready/      # Infraestrutura production-ready com CI/CD
├── docs/                     # Documentação adicional e anotações
├── references/               # Links e referências dos projetos estudados
└── README.md                 # Este arquivo
```

## 🚀 Projetos de Referência

Este repositório é baseado no estudo dos seguintes projetos da comunidade:

### Fundamentos
- [alfonsof/terraform-aws-examples](https://github.com/alfonsof/terraform-aws-examples) - Exemplos progressivos baseados no livro "Terraform: Up and Running"

### Módulos Profissionais
- [terraform-aws-modules](https://github.com/terraform-aws-modules) - Coleção oficial de módulos AWS (61 repositórios)
  - [terraform-aws-vpc](https://github.com/terraform-aws-modules/terraform-aws-vpc) - Módulo VPC (3.2k ⭐)
  - [terraform-aws-eks](https://github.com/terraform-aws-modules/terraform-aws-eks) - Módulo EKS (4.8k ⭐)

### Componentes Enterprise
- [cloudposse/terraform-aws-components](https://github.com/cloudposse/terraform-aws-components) - Componentes enterprise-grade (534 ⭐)

### Best Practices
- [aws-samples/aws-terraform-best-practices](https://github.com/aws-samples/aws-terraform-best-practices) - Best practices oficiais AWS (52 ⭐)

### Arquiteturas
- [YashPimple/Terraform-AWS-Architecture](https://github.com/YashPimple/Terraform-AWS-Architecture) - Arquiteturas 2-tier e 3-tier (16 ⭐)

### Exemplos Multi-Cloud
- [futurice/terraform-examples](https://github.com/futurice/terraform-examples) - Exemplos práticos multi-cloud (839 ⭐)

### Referências
- [shuaibiyy/awesome-tf](https://github.com/shuaibiyy/awesome-tf) - Lista curada de recursos Terraform (6.2k ⭐)

### Production-Ready
- [DhruvinSoni30/Terraform_Infrastructure_Provisioning](https://github.com/DhruvinSoni30/Terraform_Infrastructure_Provisioning) - Infraestrutura multi-cliente com CI/CD

## 📖 Roteiro de Estudos

### Fase 1: Fundamentos (1-2 semanas)
- [ ] Hello World e conceitos básicos
- [ ] EC2, Security Groups, Key Pairs
- [ ] Web servers e Load Balancers
- [ ] Auto Scaling Groups
- [ ] S3 e State Management
- [ ] Variáveis e Outputs

### Fase 2: Módulos e Estrutura (2-3 semanas)
- [ ] Estrutura padrão de módulos
- [ ] Módulos reutilizáveis
- [ ] Versionamento de módulos
- [ ] Terraform Registry
- [ ] Estudo de módulos terraform-aws-vpc
- [ ] Estudo de módulos terraform-aws-eks

### Fase 3: Best Practices (1 semana)
- [ ] Convenções de nomenclatura
- [ ] Estrutura de arquivos
- [ ] Remote state e backends
- [ ] Pre-commit hooks
- [ ] Testes de infraestrutura
- [ ] Documentação automática

### Fase 4: Arquiteturas (2-3 semanas)
- [ ] Arquitetura 2-tier
- [ ] Arquitetura 3-tier
- [ ] Arquitetura com EKS
- [ ] High Availability e Disaster Recovery
- [ ] Multi-region deployment

### Fase 5: Casos de Uso Reais (2 semanas)
- [ ] WordPress on Fargate
- [ ] API com Lambda e API Gateway
- [ ] CloudFront e S3 para sites estáticos
- [ ] VPN e networking avançado

### Fase 6: Production e CI/CD (1-2 semanas)
- [ ] Pipeline CI/CD com GitHub Actions
- [ ] Pipeline CI/CD com Jenkins
- [ ] Testes automatizados
- [ ] Deployment strategies
- [ ] Monitoring e observability

## 🛠️ Pré-requisitos

- [Terraform](https://www.terraform.io/downloads) >= 1.0
- [AWS CLI](https://aws.amazon.com/cli/) configurado
- Conta AWS (Free Tier recomendado para estudos)
- [Git](https://git-scm.com/)
- Editor de código (VS Code recomendado com extensão Terraform)

## 📝 Como Usar Este Repositório

1. **Clone o repositório**
   ```bash
   git clone https://github.com/paulohenriquelyra/terraform-aws-study-cases.git
   cd terraform-aws-study-cases
   ```

2. **Navegue pelos diretórios**
   - Cada diretório contém exemplos específicos com README próprio
   - Siga a ordem sugerida no roteiro de estudos

3. **Execute os exemplos**
   ```bash
   cd 01-fundamentals/01-hello-world
   terraform init
   terraform plan
   terraform apply
   ```

4. **Documente seu aprendizado**
   - Adicione notas e observações nos arquivos
   - Crie branches para experimentações
   - Commit regularmente seu progresso

## 🎓 Recursos Adicionais

### Livros
- "Terraform: Up and Running" - Yevgeniy Brikman
- "Terraform Best Practices" - Yevgeniy Brikman

### Documentação Oficial
- [Terraform Documentation](https://www.terraform.io/docs)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [Terraform Registry](https://registry.terraform.io/)

### Cursos e Tutoriais
- [HashiCorp Learn - Terraform](https://learn.hashicorp.com/terraform)
- [AWS Terraform Tutorials](https://aws.amazon.com/getting-started/hands-on/?getting-started-all.sort-by=item.additionalFields.sortOrder&getting-started-all.sort-order=asc&awsf.getting-started-category=category%23devops&awsf.getting-started-content-type=*all)

## 🤝 Contribuições

Este é um repositório de estudos pessoais, mas sugestões e melhorias são bem-vindas através de issues e pull requests.

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 👤 Autor

**Paulo Henrique Lyra**

- GitHub: [@paulohenriquelyra](https://github.com/paulohenriquelyra)

---

⭐ Se este repositório foi útil para seus estudos, considere dar uma estrela!

**Status do Projeto**: 🚧 Em desenvolvimento ativo
