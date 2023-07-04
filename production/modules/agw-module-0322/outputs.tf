output "application_gateway_id" {
    description = "Id of the Application Gateway."
    value = azurerm_application_gateway.agw.id
}

output "public_ip_address_id" {
    description = "Id of the Public Ip Address."
    value = azurerm_application_gateway.agw.frontend_ip_configuration
}

output "gateway_ip_configuration" {
    description = "Configuration of the Application Gateway."
    value = azurerm_application_gateway.agw.gateway_ip_configuration
}