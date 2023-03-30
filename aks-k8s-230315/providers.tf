provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    storage_account_name = "4tfstate"
    container_name       = "tfstate"
    key                  = "codelab.microsoft.tfstate"

    # rather than defining this inline, the Access Key can also be sourced
    # from an Environment Variable - more information is available below.
    access_key = "${var.st_access_key}"
  }
}
