# Automação do AKS com Terraform e Ansible

O repositório é automação que provisiona com o Terraform um cluster Kubernetes na Azure e um Banco de Dados PostgreSQL. Os serviços utilizados na automação são:

  - Azure Virtual Network
  - Azure Database
  - Azure Kubernetes Service

A automação ainda conta com a instalação de alguns addons via Ansible do [NGINX Ingress Controller](https://github.com/kubernetes/ingress-nginx/tree/master/charts/ingress-nginx), [Cert Manager](https://cert-manager.io) e [Prometheus Stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack).

## :wrench: Requisitos

Os requisitos para executar a automação são:

- Terraform v0.14.4+
- Azure CLI

## :computer: Execução

Há duas formas de executar a automação, a primeira é via pipeline no modelo GitOps e a segunda é de forma manual.

### GitOps

Para execução no modelo GitOps o CI/CD foi dividido em dois workflows, sendo o [provision.yml](./.github/workflows/provision.yml) para provisionamento da infraestrutura e o [destroy](./.github/workflows/destroy.yml) para destruição da mesma. É necessário para a execução dos workflows uma secret (AZURE_CREDENTIALS) com as [credenciais da Azure](https://docs.microsoft.com/pt-br/cli/azure/create-an-azure-service-principal-azure-cli). 

O workflow de provisionamento é executado com qualquer alteração na branch master e nele contém a execução do: Login no Azure CLI, `terraform fmt`, `terraform init`, `terraform validate`, `terraform apply` e `ansible-playbook playbook_install.yml`.

Já no workflow de destruição é removido todos os recursos instalados anteriomente pelo Ansible e em seguida é destruida a infraestrutura provisionada.

### Manual

Para a execução manual primeiro é necessário logar via Azure CLI, execute:

```sh
az login
```

A automação do Terraform armazena o tfstate em um container na Azure, caso precise criar um container siga esse guia. Após a criação, atualize as informações do container no arquivo [remote.tf](./remote.tf).

Antes de provisionar a infraestrutura é necessário baixar as dependências, execute:

```sh
terraform init
```

Agora está tudo pronto para o provisiomento da infra, execute:

```sh
terraform apply
```

Com a infraestrutura porvisionada é necessário a conexão com o cluster para a instalação dos addons, execute:

```sh
az aks get-credentials --resource-group $RESOURCE_GROUP_NAME --name $AKS_NAME
```

Para instalação dos addons execute:

```sh
ansible-playbook playbook_install.yml
```

## :ballot_box_with_check: Melhorias a serem feitas

- [ ] Melhorias no terraform para utilização de workspaces para o provisionamento de múltiplos ambientes de acordo com a branch.
- [ ] Reduzir a repetição de alguns valores com a utilização de variáveis de ambiente.
- [ ] Melhoria na configuração do Azure Virtual Network.
