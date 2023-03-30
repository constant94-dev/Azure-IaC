variable "resource_group_name" {
  default = "rg-demo0321"
  description = "Name of the resource group."
}

variable "virtual_network_hub_name" {
  default = "vnet-hub"
  description = "location of the virtual network hub."
}

variable "virtual_network_hub_location" {
  default = "koreacentral"
  description = "location of the virtual network hub."
}

variable "virtual_network_spoke_name" {
  default = "vnet-spoke"
  description = "location of the virtual network spoke."
}

variable "virtual_network_spoke_location" {
  default = "koreacentral"
  description = "location of the virtual network spoke."
}

variable "vnet_tags" {
  type = map(string)

  default = {
    "name" = "Hub&Spoke"
  }
}

variable "virtual_machine_name" {
  default = "vm-bastion"
  description = "Name of the virtual machine."
}

variable "vm_size" {
  default = "Standard_F2"
  description = "size of the virtual machine."
}

variable "admin_username" {
  default = "nodamen17"
  description = "admin username of the virtual machine."
}

variable "storage_account_type" {
  default = "StandardSSD_LRS"
  description = "storage account type of the virtual machine."
}

variable "os_publisher" {
  default = "Canonical"
  description = "os_publisher of the virtual machine."
}

variable "os_offer" {
  default = "UbuntuServer"
  description = "os_offer of the virtual machine."
}

variable "os_sku" {
  default = "18.04-LTS"
  description = "os_sku of the virtual machine."
}

variable "os_version" {
  default = "latest"
  description = "os_version of the virtual machine."
}

variable "vm_tags" {
  type = map(string)

  default = {
    "name" = "bastion"
  }
}

variable "enable_accelerated_networking" {
  default = true
  description = "accelerated of the enable accelerated networking"
}