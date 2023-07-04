output "identity_id" {
    value = azurerm_user_assigned_identity.id.id
}

output "client_id" {
    value = azurerm_user_assigned_identity.id.client_id
}

output "principal_id" {
    value = azurerm_user_assigned_identity.id.principal_id
}

output "tenant_id" {
    value = azurerm_user_assigned_identity.id.tenant_id
}