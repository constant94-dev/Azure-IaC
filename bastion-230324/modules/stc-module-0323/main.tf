resource "azurerm_storage_container" "stc" {
  name                  = "stc-${var.storage_account_container_name}"
  storage_account_name  = var.storage_account_name
  container_access_type = "private"
}