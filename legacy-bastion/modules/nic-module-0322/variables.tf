variable "resource_group_name" {
    description = "Name of the resource group."
}

variable "resource_group_location" {
    description = "Location of the resource group."
}

variable "network_interface_name" {
    description = "Name of the network interface."
}

variable "subnet_id" {
    description = "Id of the subnet."
}

variable "public_ip_address_id" {
    description = "Id of the public ip address."
}

variable "tags" {
    description = "Tags to set on the network interface."
}