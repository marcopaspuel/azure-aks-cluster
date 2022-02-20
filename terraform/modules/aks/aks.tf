resource "azurerm_kubernetes_cluster" "default" {
  name                = "${var.aks_cluster_name}-aks"
  location            = var.location
  resource_group_name = var.resource_group
  dns_prefix          = "${var.aks_cluster_name}-k8s"

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
    project = var.project
  }
}
