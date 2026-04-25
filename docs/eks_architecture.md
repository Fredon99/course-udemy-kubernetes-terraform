# Arquitetura AWS EKS

## Visão geral

Cluster Kubernetes gerenciado rodando em uma VPC.

---

## Componentes principais

### VPC

Rede isolada contendo subnets públicas e privadas.

---

### Subnets

- Públicas: acesso externo
- Privadas: nodes do cluster

---

### Gateways

- Internet Gateway: entrada
- NAT Gateway: saída

---

## EKS

### Control Plane

Gerenciado pela AWS:
- API Server
- Scheduler
- Controller
- etcd

---

### Worker Nodes

- EC2 instances
- Executam pods

---

## Fluxo de requisição

Cliente -> Load Balancer -> Service -> Pod

---

## OIDC e IAM

Permite que pods assumam roles AWS:

Pod -> ServiceAccount -> IAM Role -> AWS

---

## Boas práticas

- Subnets privadas para nodes
- Uso de OIDC
- Separação de responsabilidades
