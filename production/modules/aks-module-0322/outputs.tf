output "aks_id" {
    description = "Id of the Kubernetes."
    value = azurerm_kubernetes_cluster.aks.id
}

output "aks_fqdn" {
    description = "FQDN of the Kubernetes."
    value = azurerm_kubernetes_cluster.aks.fqdn
}

output "aks_network_profile" {
    description = "Network profile of the Kubernetes."
    value = azurerm_kubernetes_cluster.aks.network_profile
}

output "aks_node_resource_group" {
    description = "Node resource group of the Kubernetes."
    value = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "aks_nodme_resource_group_id" {
    description = "Node resource group id of the Kubernetes."
    value = azurerm_kubernetes_cluster.aks.node_resource_group_id
}

output "aks_identity" {
    description = "identity of the Kubernetes."
    value = azurerm_kubernetes_cluster.aks.identity
}