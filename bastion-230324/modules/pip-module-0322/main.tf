resource "azurerm_public_ip" "pip" {
  name                = "pip-${var.public_ip_name}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  allocation_method = "Static"
  idle_timeout_in_minutes = 30 # TCP 유휴 연결에 대한 제한 시간. 4분 ~ 30분 사이에서 설정할 수 있다.

  tags = {
    Name = "${var.tags}-pip"
  }
}