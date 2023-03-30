resource "azurerm_linux_virtual_machine" "vm" {
  name                = "vm-${var.virtual_machine_name}"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = "Standard_F2"
  admin_username      = var.admin_username
  network_interface_ids = [
    var.network_interface_ids_id
  ] # 이 가상 머신에 연결해야 하는 네트워크 인터페이스 ID 목록. 목록의 첫 번째가 기본 네트워크 인터페이스

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite" # 내부 OS 디스크에 사용해야 하는 캐싱 유형. 가능한 값은 None, ReadOnly, ReadWrite
    storage_account_type = var.storage_account_type # 내부 OS 디스크를 지원해야 하는 저장소 계정의 유형. 가능한 값은 Standard_LRS, StandardSSD_LRS, Premium_LRS, StandardSSD_ZRS, Premium_ZRS
  }

  source_image_reference { # 23.03.22 기준 Azure CLI를 통해 제공되는 sku는 18.04-LTS 가 최신버전이다.
    publisher = "Canonical" # 가상 머신을 만드는데 사용되는 이미지의 게시자
    offer     = "UbuntuServer" # 가상 머신을 만드는데 사용되는 이미지 제공자
    sku       = "18.04-LTS" # 가상 머신을 만드는데 사용되는 이미지의 SKU
    version   = "latest" # 가상 머신을 만드는데 사용되는 이미지 버전
  }

  boot_diagnostics {
    storage_account_uri = null # 하이퍼바이저의 콘솔 출력 및 스크린샷을 포함하여 부팅 진단을 저장하는 Azure Storage 계정의 주/보조 엔드포인트
  }

  tags = {
    "Name" = "${var.tags}-vm"
  }
}