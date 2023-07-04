output "name" {
    description = "Subnet id set on the network security group."
    value = azurerm_subnet_network_security_group_association.snetnsg.subnet_id
}

output "name" {
    description = "Network security group id set on the association."
    value = azurerm_subnet_network_security_group_association.snetnsg.network_security_group_id
}