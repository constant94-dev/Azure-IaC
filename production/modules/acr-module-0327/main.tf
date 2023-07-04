resource "azurerm_container_registry" "acr" {
  name                = "acr${var.container_registry_name}"
  resource_group_name = var.resource_group_name
  location            = var.resource_gorup_location
  sku                 = var.sku
  admin_enabled       = false
}