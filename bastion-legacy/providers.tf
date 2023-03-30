terraform {
  backend "azurerm" {
    resource_group_name  = "rg-demo0320"
    storage_account_name = "storagedemo0320"
    container_name       = "storage-container-demo0320"
    key                  = "demo0321.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}