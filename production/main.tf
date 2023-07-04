data "azurerm_resource_group" "rg_prod" {
  name = "rg-nodamen-prod"
}

data "terraform_remote_state" "demo0324" {
  backend = "azurerm"
  config = {
    storage_account_name = "stdemo0324"
    container_name       = "stc-demo0324"
    key                  = "demo0324.terraform.tfstate"

    access_key = "${var.remote_access_key}"
  }
}

module "storage_account" {
    source = "./modules/st-module-0322"

    storage_account_name = "nodamen0324"
    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_group_location = data.azurerm_resource_group.rg_prod.location
}

module "storage_account_container" {
    source = "./modules/stc-module-0323"

    storage_account_container_name = "nodamen0324"
    storage_account_name = module.storage_account.storage_account_name
}

module "virtual_network_spoke" {
    source = "./modules/vnet-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    location = data.azurerm_resource_group.rg_prod.location

    virtual_network_name = "Spoke"
    vnet_address_space = ["10.11.0.0/16"]

    tags = "Spoke0324"
}

module "subnet_spoke_aks" {
    source = "./modules/snet-module-0323"

    resource_group_name = data.azurerm_resource_group.rg_prod.name

    subnet_name = "aks0704"    
    address_prefixes = ["10.11.1.0/24"]

    virutal_network_name = module.virtual_network_spoke.name
}

module "subnet_spoke_database" {
    source = "./modules/snet-module-0323"

    resource_group_name = data.azurerm_resource_group.rg_prod.name

    subnet_name = "database0324"
    address_prefixes = ["10.11.2.0/24"]

    virutal_network_name = module.virtual_network_spoke.name
}

module "subnet_hub_agw" {
    source = "./modules/snet-module-0323"

    resource_group_name = data.azurerm_resource_group.rg_prod.name

    subnet_name = "agw0324"
    address_prefixes = ["10.10.2.0/24"]

    virutal_network_name = "${data.terraform_remote_state.demo0324.outputs.virtual_network_name}"
}

module "peering_hub" {
    source = "./modules/peer-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name

    virtual_network_origin_name = "${data.terraform_remote_state.demo0324.outputs.virtual_network_name}"
    virtual_network_edge_name = module.virtual_network_spoke.name

    remote_virtual_network_edge_id = module.virtual_network_spoke.id
}

module "peering_spoke" {
    source = "./modules/peer-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name

    virtual_network_origin_name = module.virtual_network_spoke.name
    virtual_network_edge_name = "${data.terraform_remote_state.demo0324.outputs.virtual_network_name}"

    remote_virtual_network_edge_id = "${data.terraform_remote_state.demo0324.outputs.virtual_network_id}"
}

module "container_registry_dev" {
    source = "./modules/acr-module-0327"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_gorup_location = data.azurerm_resource_group.rg_prod.location

    container_registry_name = "dev0327"
    sku = "Basic"
}

module "container_registry_prod" {
    source = "./modules/acr-module-0327"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_gorup_location = data.azurerm_resource_group.rg_prod.location

    container_registry_name = "prod0327"
    sku = "Basic"
}

module "application_gatway" {
    source = "./modules/agw-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_gorup_location = data.azurerm_resource_group.rg_prod.location

    agw_name = "hubVnet0329"
    public_ip_address_id = module.public_ip_agw.id
    subnet_id = module.subnet_hub_agw.id

    request_routing_rule_priority = 10

    tags = "hubVnet0329"
}

module "public_ip_agw" {
    source = "./modules/pip-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_group_location = data.azurerm_resource_group.rg_prod.location

    public_ip_name = "agw0329"

    tags = "agw0329"
}

module "user_assigned_identity" {
    source = "./modules/id-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_group_location = data.azurerm_resource_group.rg_prod.location

    identity_name = "nodamen0329"

    tags = "nodamen0329"
}

module "role_assignment_contributor" {
    source = "./modules/role-module-0330"

    role_definition_name = "Contributor0330"
    # role_definition_scope = data.azurerm_subscription.primary.id
    role_definition_actions = "*"

    # role_assignment_name = "contributor0330"
    # role_assignment_scope = data.azurerm_subscription.primary.id
    principal_id = module.user_assigned_identity.principal_id
}

module "role_assignment_reader" {
    source = "./modules/role-module-0330"

    role_definition_name = "Reader0330"
    # role_definition_scope = data.azurerm_subscription.primary.id
    role_definition_actions = "Microsoft.Resources/subscriptions/resourceGroups/read"

    # role_assignment_name = "reader0330"
    # role_assignment_scope = data.azurerm_subscription.primary.id
    principal_id = module.user_assigned_identity.principal_id
}

module "kubernetes_cluster" {
    source = "./modules/aks-module-0322"

    resource_group_name = data.azurerm_resource_group.rg_prod.name
    resource_gorup_location = data.azurerm_resource_group.rg_prod.location

    aks_name = "nodamenk8s"
    kubernetes_version = 1.26
    aks_dns_prefix = "nodamenk8s"

    admin_username = "nodamen17"
    aks_public_ssh_key_path = "~/.ssh/authorized_keys"

    aks_node_count = 3
    aks_os_disk_size_gb = 64
    aks_type = "VirtualMachineScaleSets"
    aks_vm_size = "Standard_DS2_v2"
    aks_subnet_id = module.subnet_spoke_aks.id
    aks_max_pods = 60
    
    aks_identity_ids = module.user_assigned_identity.identity_id

    aks_dns_service_ip = "192.168.100.10"
     # docker_bridge_cidr은 공급자 버전 4.0부터 제거된다.
    aks_docker_bridge_cidr = "172.17.0.1/16" # 172.17.0.0 ~ 172.17.255.255 (65,536개)
    aks_service_cidr = "192.168.100.0/24"

    tags = "spokeVnet0704"
}