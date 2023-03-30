output "storage_container_id" {
    description = "Id of the storage container."
    value = azurerm_storage_container.stc.id
}

output "storage_container_name" {
    description = "Name of the storage account container."
    value = azurerm_storage_container.stc.name
}

output "storage_account_name" {
    description = "Name set on the storage account."
    value = azurerm_storage_container.stc.storage_account_name
}