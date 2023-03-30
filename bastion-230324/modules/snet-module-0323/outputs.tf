output "id" {
    description = "Id of the subnet."
    value = azurerm_subnet.snet.id
}

output "name" {
    description = "Name of the subnet."
    value = azurerm_subnet.snet.name
}

output "virutal_network_name" {
    description = "Name set on the virtual network."
    value = azurerm_subnet.snet.virtual_network_name
}

output "address_prefixes" {
    description = "Address prefixes set on the subnet."
    value = azurerm_subnet.snet.address_prefixes
}