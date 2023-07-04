variable "resource_group_name" {
    description = "Name of the resource group."
}

variable "resource_gorup_location" {
    description = "Location of the resource group."
}

variable "agw_name" {
    description = "Name of the Application Gateway."
}

variable "subnet_id" {
    description = "Subnet id set on the Application Gateway."
}

variable "public_ip_address_id" {
    description = "public_ip_address_id set on the Application Gateway."
}

variable "request_routing_rule_priority" {
    description = "Rule priority between 1 to 20000."
}

variable "tags" {
    description = "Tags set on the Application Gateway."
}