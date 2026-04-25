

### 1. Criação do cluster

Comando para verificar o caller usado

> aws sts get-caller-identity

- Criação da role
- Configuração do cluster
- Networking
- Observabilidade
- Add-ons
- Configuração dos add-ons
- Revisão e criação


#### 1.1 Vericando conexão com o cluster

``` bash
host <CLUSTER_ENDPOINT_ID>.gr7.<region>.eks.amazonaws.com
nc -v <CLUSTER_ENDPOINT_ID>.gr7.<region>.eks.amazonaws.com 443
```

#### 1.2 Configurando kubectl

##### 1.2.1 Comando aws para gerar novo contexto
``` bash
aws eks update-kubeconfig --region [region] --name [cluster-name]
```

##### 1.2.2 Adicionando novo contexto no kubectl
``` bash
kubectl config use-context [generated-arn]
```

### 2. Criação do Managed Node Group

- Criação da role
- Configuração do node group
- Configuração dos nós e scaling
- Networking
- Revisão e criação

### 3. Criação do OIDC

#### 3.1 Instalação do Eksctl

```bash
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo install -m 0755 /tmp/eksctl /usr/local/bin && rm /tmp/eksctl
```

#### 3.2 Criando OIDC Provider

Obtém OIDC issuer ID
```bash
cluster_name=<my-cluster>
oidc_id=$(aws eks describe-cluster --name $cluster_name --query "cluster.identity.oidc.issuer" --output text | cut -d '/' -f 5)
echo $oidc_id
```

Verifica se já existe um OIDC Provider com esse ID na conta
```bash
aws iam list-open-id-connect-providers | grep $oidc_id | cut -d "/" -f4
```

Cria OIDC identity provider para o cluster
```bash
eksctl utils associate-iam-oidc-provider --cluster $cluster_name --approve
```

### 4. Deploy do load balancer controller

#### 4.1 IAM role

```bash
curl -O https://raw.githubusercontent.com/kubernetes-sigs/aws-load-balancer-controller/v2.14.1/docs/install/iam_policy.json
```

```bash
aws iam create-policy \
    --policy-name AWSLoadBalancerControllerIAMPolicy \
    --policy-document file://iam_policy.json
```


```bash
eksctl create iamserviceaccount \
    --cluster=<cluster-name> \
    --namespace=kube-system \
    --name=aws-load-balancer-controller \
    --attach-policy-arn=arn:aws:iam::<AWS_ACCOUNT_ID>:policy/AWSLoadBalancerControllerIAMPolicy \
    --override-existing-serviceaccounts \
    --region <aws-region-code> \
    --approve
```

#### 4.1 Instalação do load balancer controller

Adicione o repositório de gráficos Helm eks-charts.
```bash
helm repo add eks https://aws.github.io/eks-charts
```

Atualize seu repositório local para garantir que você tenha os gráficos mais recentes.
```bash
helm repo update eks
```

Install the AWS Load Balancer Controller.
```bash
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-cluster \
  --set serviceAccount.create=false \
  --set serviceAccount.name=aws-load-balancer-controller \
  --set region=region-code \
  --set vpcId=vpc-xxxxxxxx \
  --version 1.14.0
```