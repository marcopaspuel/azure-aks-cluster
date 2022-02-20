resource "azurerm_resource_group" "neptune" {
  name     = var.resource_group
  location = var.location

  tags = {
    Project = var.project
  }
}