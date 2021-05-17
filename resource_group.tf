resource "azurerm_resource_group" "conductor" {
  name     = local.config.resource_group.name
  location = local.config.resource_group.location
}
