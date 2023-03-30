resource "azurerm_network_interface" "nic" {
  name = "nic-${var.network_interface_name}"
  resource_group_name = var.resource_group_name
  location = var.resource_group_location  

  enable_accelerated_networking = true # 가속 네트워킹 활성화 여부

  ip_configuration {
    name = "internal"
    subnet_id = var.subnet_id # 이 네트워크 인터페이스가 있어야 하는 서브넷 ID
    private_ip_address_allocation = "Dynamic" # private ip 주소 할당 방법
    public_ip_address_id = var.public_ip_address_id # NIC와 연결할 공용 IP 주소에 대한 참조
  }

  tags = {
    "Name" = "${var.tags}-nic"
  }
}