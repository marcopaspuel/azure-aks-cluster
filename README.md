# azure-aks-cluster
This project contains a Terraform template to deploy a customizable Kubernetes cluster in Azure Kubernetes Service (AKS).

## Prerequisites

* [Python 3.8 or higher](https://www.python.org/)
* [Make](https://wiki.ubuntuusers.de/Makefile/)
* [Terraform 1.0.9](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/azure-get-started)
* [Kubectl v1.22.4](https://kubernetes.io/docs/tasks/tools/)
* [Helm v3.5.4](https://helm.sh/docs/intro/install/)
* [jq-1.6](https://stedolan.github.io/jq/download/)
* [Azure CLI 2.29.0](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt#option-1-install-with-one-command)

Make sure you are authenticated and authorized in the azure-cli with the following command:

```bash
az login
```
### Recommended Tooling
* [Lens](https://k8slens.dev/)
