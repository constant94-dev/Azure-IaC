terraform {
  backend "azurerm" {
    resource_group_name  = "rg-nodamen-prod"
    storage_account_name = "stnodamen0324"
    container_name       = "stc-nodamen0324"
    key                  = "0324.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}