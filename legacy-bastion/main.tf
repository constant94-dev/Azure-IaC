# data "terraform_remote_state" "remote" {
#   backend = "azurerm"
#   config = {
#     storage_account_name = "storagedemo0320"
#     container_name       = "storage-container-demo0320"
#     key                  = "demo0321.terraform.tfstate"
#   }
# }

resource "azurerm_resource_group" "rg_storage" {
    name     = "rg-demo0324"
    location = "koreacentral"

    tags = {
        "Name" = "demo0324-rg"
    }
}

resource "azurerm_resource_group" "rg_prod" {
    name     = "rg-nodamen-prod"
    location = "koreacentral"

    tags = {
        "Name" = "nodamen-prod-rg"
    }
}

module "storage_account" {
    source = "./modules/st-module-0322"

    storage_account_name = "demo0324"
    resource_group_name = azurerm_resource_group.rg_storage.name
    resource_group_location = azurerm_resource_group.rg_storage.location
}

module "storage_account_container" {
    source = "./modules/stc-module-0323"

    storage_account_container_name = "demo0324"
    storage_account_name = module.storage_account.storage_account_name
}

module "virtual_machine" {
    source = "./modules/vm-module-0322"

    resource_group_name = azurerm_resource_group.rg_prod.name
    resource_group_location = azurerm_resource_group.rg_prod.location

    virtual_machine_name = "bastion0324"
    admin_username = "nodamen17"
    ssh_public_key = file("${var.ssh_public_key}")

    network_interface_ids_id = module.network_interface.id
    storage_account_type = "StandardSSD_LRS"

    tags = "bastion0324"
}

module "network_interface" {
    source = "./modules/nic-module-0322"

    network_interface_name = "bastion0324"
    public_ip_address_id = module.public_ip.id

    resource_group_name = azurerm_resource_group.rg_prod.name
    resource_group_location = azurerm_resource_group.rg_prod.location

    subnet_id = module.subnet.id

    tags = "bastion0324"

}

module "public_ip" {
    source = "./modules/pip-module-0322"

    public_ip_name = "bastion0324"

    resource_group_name = azurerm_resource_group.rg_prod.name
    resource_group_location = azurerm_resource_group.rg_prod.location

    tags = "bastion0324"
}

module "virtual_network" {
    source = "./modules/vnet-module-0322"

    resource_group_name = azurerm_resource_group.rg_prod.name
    location = azurerm_resource_group.rg_prod.location

    virtual_network_name = "Hub"
    vnet_address_space = ["10.10.0.0/16"]

    tags = "Hub0324"
}


module "subnet" {
    source = "./modules/snet-module-0323"

    resource_group_name = azurerm_resource_group.rg_prod.name

    subnet_name = "bastion0324"
    address_prefixes = ["10.10.1.0/24"]

    virutal_network_name = module.virtual_network.name
}