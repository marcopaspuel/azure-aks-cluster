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

module "aks" {
  source               = "./modules/aks"
  resource_group       = var.aks_rg_name
  location             = var.aks_rg_location
  aks_cluster_name     = var.aks_cluster_name
  project              = var.project
}
