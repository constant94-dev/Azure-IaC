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
    access_key = "K0omlNoj7ins6d3PMs5KdS5NMsmGlLzxj/qRf/2DjMe1T5UBAN9BNd/jsSstBTQAuKFpO/8S82aA+AStzt/WVw=="
  }
}
