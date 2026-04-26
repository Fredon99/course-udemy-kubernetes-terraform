# EKS Cluster Provisioning com Terraform

Projeto para provisionamento de infraestrutura completa na AWS utilizando Terraform.

Este repositório contém:
- Infraestrutura de rede (VPC, subnets, gateways)
- Cluster EKS
- Node groups
- IAM e OIDC
- Documentação passo a passo e arquitetural

---

## Objetivo

Este projeto tem dois objetivos:

1. Aprendizado prático de Terraform + AWS + EKS
2. Compreensão da arquitetura por trás da infraestrutura

---

## Estrutura do Projeto

```
modules/
├── network/    # VPC, subnets, IGW, NAT Gateway
└── cluster/    # EKS cluster, IAM, node groups

docs/
├── terraform_workflow.md   # Fluxo de trabalho e comandos Terraform
├── eks_architecture.md     # Arquitetura da AWS e EKS
└── cluster_creation.md     # Criação manual do cluster (kubectl, OIDC, LB controller)
```

---

## Execução (passo a passo)

### 0. Configurar backend

Copie o arquivo de exemplo e preencha com seus valores:

```bash
cp backend.hcl.example backend.hcl
```

### 1. Inicializar o Terraform

```bash
terraform init -backend-config=backend.hcl
```

### 2. Validar arquivos

```bash
terraform validate
```

### 3. Planejar execução

```bash
terraform plan
```

### 4. Aplicar infraestrutura

```bash
terraform apply -auto-approve
```

---

## Documentação complementar

| Documento | Descrição |
|---|---|
| [terraform_workflow.md](docs/terraform_workflow.md) | Fluxo de trabalho, comandos e boas práticas do Terraform |
| [eks_architecture.md](docs/eks_architecture.md) | Arquitetura da AWS, VPC, EKS, OIDC e IAM |
| [cluster_creation.md](docs/cluster_creation.md) | Criação do cluster, kubectl, OIDC provider e Load Balancer Controller |
