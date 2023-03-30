output "resource_group_prod_name" {
    value = azurerm_resource_group.rg_prod.name
}

output "resource_group_storage_name" {
    value = azurerm_resource_group.rg_storage.name
}

output "virtual_network_name" {
    value = module.virtual_network.name
}

output "virtual_network_id" {
    value = module.virtual_network.id
}