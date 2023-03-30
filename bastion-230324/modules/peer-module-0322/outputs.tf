output "origin_name" {
    value = azurerm_virtual_network_peering.peer.virtual_network_name
}

output "edge_id" {
    value = azurerm_virtual_network_peering.peer.remote_virtual_network_id
}