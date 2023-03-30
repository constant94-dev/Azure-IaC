resource "azurerm_linux_virtual_machine" "bastion" {
  name = var.virtual_machine_name
  resource_group_name = data.azurerm_resource_group.rg.name
  location = data.azurerm_resource_group.rg.location
  size = var.vm_size
  admin_username = var.admin_username
  network_interface_ids = [
    azurerm_network_interface.bastion.id
  ] # 이 가상 머신에 연결해야 하는 네트워크 인터페이스 ID 목록. 목록의 첫 번째가 기본 네트워크 인터페이스

  admin_ssh_key {
    username = var.admin_username
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching = "ReadWrite" # 내부 OS 디스크에 사용해야 하는 캐싱 유형. 가능한 값은 None, ReadOnly, ReadWrite
    storage_account_type = var.storage_account_type # 내부 OS 디스크를 지원해야 하는 저장소 계정의 유형. 가능한 값은 Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS, Premium_ZRS
  }

  source_image_reference {
    publisher = var.os_publisher # 가상 머신을 만드는데 사용되는 이미지의 게시자
    offer = var.os_offer # 가상 머신을 만드는데 사용되는 이미지 제공자
    sku = var.os_sku # 가상 머신을 만드는데 사용되는 이미지의 SKU
    version = var.os_version # 가상 머신을 만드는데 사용되는 이미지 버전
  }

  boot_diagnostics {
    storage_account_uri = null # 하이퍼바이저의 콘솔 출력 및 스크린샷을 포함하여 부팅 진단을 저장하는 Azure Storage 계정의 주/보조 엔드포인트
  }
}

# bastion virtual machine network interface
resource "azurerm_network_interface" "bastion" {
  name = "${var.virtual_machine_name}-nic"
  location = var.virtual_network_hub_location
  resource_group_name = data.azurerm_resource_group.rg.name

  enable_accelerated_networking = var.enable_accelerated_networking # 가속 네트워킹 활성화 여부

  tags = var.vm_tags

  ip_configuration {
    name = "internal"
    subnet_id = azurerm_subnet.bastion.id # 이 네트워크 인터페이스가 있어야 하는 서브넷 ID
    private_ip_address_allocation = "Dynamic" # private ip 주소 할당 방법
    public_ip_address_id = azurerm_public_ip.bastion.id # NIC와 연결할 공용 IP 주소에 대한 참조
  }
}

# bastion virtual machine public ip
resource "azurerm_public_ip" "bastion" {
  name = "${var.virtual_machine_name}-pip"
  location = var.virtual_network_hub_location
  resource_group_name = data.azurerm_resource_group.rg.name  
  allocation_method = "Static"
  idle_timeout_in_minutes = 30 # TCP 유휴 연결에 대한 제한 시간. 4분 ~ 30분 사이에서 설정할 수 있다.

  tags = var.vm_tags
}