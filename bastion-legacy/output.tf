output "bastion_subnet_id" {
  value = azurerm_subnet.bastion.id
}

output "bastion_nic_id" {
    value = azurerm_network_interface.bastion.id
}

output "bastion_subnet_nsg_id" {
  value = azurerm_network_security_group.nsg.id
}

output "peering_HtoS_remote_id" {
  value = azurerm_virtual_network.SpokeVnet.id
}

output "peering_StoH_remote_id" {
  value = azurerm_virtual_network.HubVnet.id
}

output "virtual_network_hub_name" {
  value = azurerm_virtual_network.HubVnet.name
}