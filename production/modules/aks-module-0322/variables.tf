variable "resource_group_name" {
    description = "Name of the resource group."
}

variable "resource_gorup_location" {
    description = "Location of the resource group."
}

variable "aks_name" {
    description = "Name of the Kubernetes."
}

variable "kubernetes_version" {
    description = "Version set on the Kubernetes."
}

variable "aks_dns_prefix" {
    description = "DNS prefix specified when creating the managed cluster."
}

variable "aks_node_count" {
    description = "Node count set on the Kubernetes node pool."
}

variable "aks_os_disk_size_gb" {
    description = "OS disk size(GB) set on the Kubernetes node pool."
}

variable "aks_type" {
    description = "type set on the Kubernetes node pool."
}

variable "aks_vm_size" {
    description = "VM size set on the Kubernetes node pool."
}

variable "aks_subnet_id" {
    description = "Subnet id set on the Kubernetes node pool."
}

variable "aks_max_pods" {
    description = "Max pods set on the Kubernetes node pool."
}

variable "aks_dns_service_ip" {
    description = "DNS server IP address."
    # default     = "10.0.0.10"
}

variable "aks_docker_bridge_cidr" {
    description = "CIDR notation IP for Docker bridge."
    # default     = "172.17.0.1/16"
}

variable "aks_service_cidr" {
    description = "CIDR notation IP range from which to assign service cluster IPs."
    # default     = "10.0.0.0/16"
}

variable "aks_identity_ids" {
    description = "Ids set on the aks identity."
}

variable "admin_username" {
    description = "Admin username set on the Kubernetes."
}

variable "aks_public_ssh_key_path" {
    description = "SSH key path set on the Kubernetes."
    sensitive = true
}

variable "tags" {
    description = "Tags set on the Kubernetes."
}