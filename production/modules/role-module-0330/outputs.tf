output "role_assignment_id" {
    value = azurerm_role_assignment.ra.id
}

output "role_assignment_scope" {
    value = azurerm_role_assignment.ra.scope
}

output "role_assignment_principal_id" {
    value = azurerm_role_assignment.ra.principal_id
}