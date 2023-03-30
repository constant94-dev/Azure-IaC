output "id" {
    description = "Id of the virtual network."
    value = azurerm_virtual_network.vnet.id
}

output "name" {
    description = "Name of the virtual network."
    value = azurerm_virtual_network.vnet.name
}

output "address_space" {
    description = "address_space of the virtual network."
    value = azurerm_virtual_network.vnet.address_space
}