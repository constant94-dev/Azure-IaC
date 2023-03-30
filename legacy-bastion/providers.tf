terraform {
  backend "azurerm" {
    resource_group_name  = "rg-demo0324"
    storage_account_name = "stdemo0324"
    container_name       = "stc-demo0324"
    key                  = "demo0324.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}