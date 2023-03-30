resource "azurerm_network_security_group" "nsg" {
  name = "nsg-${var.network_security_group_name}"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location  

  tags = {
    "Name" = "${var.tags}-nsg"
  }
}

resource "azurerm_network_security_rule" "nsgsr" {
  name = "nsgsr-${var.network_security_rule_name}"
  resource_group_name = var.resource_group_name
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

resource "azurerm_subnet_network_security_group_association" "nsgsnet" {
  subnet_id = var.subnet_id # 서브넷의 ID
  network_security_group_id = azurerm_network_security_group.nsg.id # 서브넷과 연결되어야 하는 네트워크 보안 그룹 ID
}