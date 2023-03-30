variable "resource_group_name" {
    description = "Name of the resource group. Must be unique."
}

variable "virtual_network_name" {
    description = "Name of the virtual network."
}

variable "location" {
    description = "Location of the virtual network."
}

variable "vnet_address_space" {
  description = "address space set on the virtual network."
}

variable "tags" {
    description = "Tags to set on the virtual network."
    # type = map(string)
    # default = {}
}