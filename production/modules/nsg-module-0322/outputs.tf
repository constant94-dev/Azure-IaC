output "id" {
   description = "Id of the network security."
   value = azurerm_network_security_group.nsg.id
}

output "nsg_connected_snet" {
   description = "Snet set on the network security group."
   value = azurerm_subnet_network_security_group_association.nsgsnet.id
}