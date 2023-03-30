resource "azurerm_user_assigned_identity" "id" {
  name                = "id-${var.identity_name}"    
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  tags = {
    "Name" = "${var.tags}-id"
  }
}