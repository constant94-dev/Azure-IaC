resource "azurerm_subnet" "snet" {
  name = "snet-${var.subnet_name}"
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virutal_network_name
  address_prefixes = var.address_prefixes
}