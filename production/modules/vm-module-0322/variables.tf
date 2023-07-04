variable "resource_group_name" {
    description = "Name of the resource group. Must be unique"
}

variable "resource_group_location" {
    description = "Location of the resource group."
}

variable "virtual_machine_name" {  
    description = "Name of the virtual machine. Must be unique."
}

variable "admin_username" {
    description = "admin username of the virtual machine."
}

variable "ssh_public_key" {
    description = "SSH key set on the virtual machine."
    sensitive = true
}

variable "network_interface_ids_id" {
    description = "Ids of the network interface."
}

variable "storage_account_type" {
    description = "type of the storage account. Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS and Premium_ZRS."
}

variable "tags" {
    description = "Tags to set on the virtual machine."
    # type = map(string)
    # default = {}
}