data "azurerm_subscription" "primary" {
}

resource "azurerm_role_definition" "rd" {
  name               = "rd-${var.role_definition_name}"
  scope              = data.azurerm_subscription.primary.id

  permissions {
    actions     = ["${var.role_definition_actions}"]
    not_actions = []
  }

  assignable_scopes = [
    data.azurerm_subscription.primary.id, # /subscriptions/00000000-0000-0000-0000-000000000000
  ]
}

resource "azurerm_role_assignment" "ra" {
  # name = "ra-${var.role_assignment_name}"
  scope              = data.azurerm_subscription.primary.id
  role_definition_id = azurerm_role_definition.rd.role_definition_resource_id
  principal_id       = var.principal_id
}