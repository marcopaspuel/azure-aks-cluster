provider "azuread" {
  tenant_id = var.tenant_id
}

provider "azurerm" {
  features {}
}

terraform {
    required_providers {
      azurerm = {
        source  = "hashicorp/azurerm"
        version = ">= 2.0"
      }
    }

  backend "azurerm" {}
}

module "resource_group" {
  source               = "./modules/resource_group"
  resource_group       = var.aks_rg_name
  location             = var.aks_rg_location
  project              = var.project
}

resource "random_pet" "prefix" {}

resource "azurerm_kubernetes_cluster" "default" {
  name                = "${random_pet.prefix.id}-aks"
  location            = var.aks_rg_location
  resource_group_name = var.aks_rg_name
  dns_prefix          = "${random_pet.prefix.id}-k8s"

  default_node_pool {
    name            = "default"
    node_count      = 2
    vm_size         = "Standard_D2_v2"
    os_disk_size_gb = 30
  }

  identity {
    type = "SystemAssigned"
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    environment = "Demo"
  }
}
