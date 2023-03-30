resource "azurerm_virtual_network" "vnet" {
  name = "vnet-${var.virtual_network_name}"
  location = var.location
  resource_group_name = var.resource_group_name
  address_space = var.vnet_address_space

  tags = {
    "Name" = "${var.tags}-vnet"
  }
}