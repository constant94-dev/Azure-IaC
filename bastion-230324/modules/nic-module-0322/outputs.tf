output "id" {
    description = "Id of the network interface."
    value = azurerm_network_interface.nic.id
}

output "network_interface_name" {
    description = "Nmae of the network interface."
    value = azurerm_network_interface.nic.name
}

output "ip_configuration" {
    description = "IP configuration of the network interface."
    value = azurerm_network_interface.nic.ip_configuration
}