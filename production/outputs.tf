output "resource_group_id" {
    description = "Id of the resource group."
    value = data.azurerm_resource_group.rg_prod.id
}

output "storage_account_name" {
    description = "Name of the storage accunt."
    value = module.storage_account.storage_account_name
}

output "container_registry_dev_id" {
    description = "Id of the container registry dev."
    value = module.container_registry_dev.container_registry_id
}

output "container_registry_prod_id" {
    description = "Id of the container registry prod."
    value = module.container_registry_prod.container_registry_id
}