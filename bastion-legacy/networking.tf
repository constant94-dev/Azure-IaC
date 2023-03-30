data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

# Hub virtual network
resource "azurerm_virtual_network" "HubVnet" {
  name = var.virtual_network_hub_name
  location = var.virtual_network_hub_location
  resource_group_name = data.azurerm_resource_group.rg.name
  address_space = [ "10.11.0.0/16" ]

  tags = var.vnet_tags
}

# Application gateway in Hub subnet
resource "azurerm_subnet" "appgw" {
  name = "subnet-appgw"
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.HubVnet.name
  address_prefixes = [ "10.11.1.0/24" ]
}

# Bastion in Hub subnet
resource "azurerm_subnet" "bastion" {
  name = "subnet-bastion"
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.HubVnet.name
  address_prefixes = [ "10.11.2.0/24" ]
}

resource "azurerm_virtual_network" "SpokeVnet" {
  name = var.virtual_network_spoke_name
  location = var.virtual_network_spoke_location
  resource_group_name = data.azurerm_resource_group.rg.name  
  address_space = [ "10.12.0.0/16" ]

  tags = var.vnet_tags
}

# Azure Kubernetes Services in Spoke subnet
resource "azurerm_subnet" "aks" {
  name = "subnet-aks"
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.SpokeVnet.name
  address_prefixes = [ "10.12.1.0/24" ]
}

# Bastion이 사용할 네트워크 보안 그룹
resource "azurerm_network_security_group" "nsg" {
  name = "nsg-bastion"
  location = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
}

# Bastion이 사용할 inbound 규칙
resource "azurerm_network_security_rule" "inbound" {
  name = "Allow"
  resource_group_name = data.azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
  priority = 100
  direction = "Inbound"
  access = "Allow"
  protocol = "Tcp"
  source_port_range = "*" # 가용할 소스(출발지) 포트 0부터 65535사이의 정수 or 범위
  destination_port_ranges = ["22"] # 가용할 목적지 포트 0부터 65535사이의 정수 or 범위
  source_address_prefix = "*" # 가용할 CIDR or 소스 IP or 모든(any) IP
  destination_address_prefix = "*" # 가용할 CIDR or 목적지 IP or 모든(any) IP
}

# Bastion subnet과 사용할 네트워크 보안 그룹 연결
resource "azurerm_subnet_network_security_group_association" "bastionsubnet" {
  subnet_id = azurerm_subnet.bastion.id # 서브넷의 ID
  network_security_group_id = azurerm_network_security_group.nsg.id # 서브넷과 연결되어야 하는 네트워크 보안 그룹 ID
}

# Hub to Spoke
resource "azurerm_virtual_network_peering" "HtoS" {
  name = "${var.virtual_network_hub_name}-to-${var.virtual_network_spoke_name}"
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.HubVnet.name
  remote_virtual_network_id = azurerm_virtual_network.SpokeVnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}

# Spoke to Hub
resource "azurerm_virtual_network_peering" "StoH" {
  name = "${var.virtual_network_spoke_name}-to-${var.virtual_network_hub_name}"
  resource_group_name = data.azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.SpokeVnet.name
  remote_virtual_network_id = azurerm_virtual_network.HubVnet.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true
  allow_gateway_transit        = false
  use_remote_gateways          = false
}