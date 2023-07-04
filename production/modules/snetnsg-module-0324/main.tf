resource "azurerm_subnet_network_security_group_association" "snetnsg" {
  subnet_id = var.subnet_id # 서브넷의 ID
  network_security_group_id = var.network_security_group_id # 서브넷과 연결되어야 하는 네트워크 보안 그룹 ID
}