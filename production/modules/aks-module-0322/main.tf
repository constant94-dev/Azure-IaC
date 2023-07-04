resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-${var.aks_name}"
  location            = var.resource_gorup_location
  resource_group_name = var.resource_group_name
  kubernetes_version = var.kubernetes_version
  dns_prefix          = var.aks_dns_prefix # 관리형 클러스터를 만들 때 지정된 DNS 접두사
  # 쿠버네티스의 경우 다른 Pod를 찾을 시 동일 네임스페이스 안에서 찾을 때 PQDN을 사용하고, 네임스페이스 외부에서 찾을 때 FQDN을 사용한다.

  azure_policy_enabled = true # 한 곳에서 Kubernetes 클러스터의 규정 준수 상태를 관리하고 보고할 수 있다
  #private_cluster_enabled          = false # 이 Kubernetes의 API 서버를 내부 IP 주소에만 노출 여부. 기본값 false
  #http_application_routing_enabled = true # HTTP 애플리케이션 라우팅 활성화 여부. 중국 또는 미국 정부에서 지원안됨

  linux_profile { # SSH를 사용하여 워커노드에 로그인 할 수 있는 설정
    admin_username = var.admin_username

    ssh_key {
      key_data = "${file("${var.aks_public_ssh_key_path}")}"
    }
  }

  default_node_pool {
    name            = "defaultpool"
    node_count      = var.aks_node_count    
    os_disk_size_gb = var.aks_os_disk_size_gb
    type            = var.aks_type
    vm_size         = var.aks_vm_size
    vnet_subnet_id  = var.aks_subnet_id # Kubernetes 노드 풀이 있어야 하는 서브넷 ID
    max_pods        = var.aks_max_pods
  }

  identity {
    type = "UserAssigned" # 이 Kubernetes 클러스터에서 구성해야 하는 관리 서비스 ID 유형을 지정한다
    identity_ids = [var.aks_identity_ids] # 이 Kubernetes 클러스터에 할당할 사용자 할당 관리 ID 목록을 지정한다
  }
  
#   service_principal {
#     client_id     = var.aks_service_principal_app_id
#     client_secret = var.aks_service_principal_client_secret
#   }

  network_profile { # AKS에 사용되는 네트워킹 프로필
    network_plugin = "azure" # 네트워킹에 사용할 네트워크 플러그인. 지원되는 값 'azure', 'kubenet', 'none'
    network_policy = "azure" # Azure CNI와 함께 사용할 네트워크 정책 설정. pods 간의 트래픽 흐름을 제어할 수 있다.
    
    # 아래의 반영된 범위는 vnet 안에 있거나 연결된 네트워크 요소에서 사용하면 안됩니다.
    # CIDR은 /12 보다 작아야 하고 모두 비어두거나 모두 설정되어야 한다.
    dns_service_ip     = var.aks_dns_service_ip # 클러스터 서비스 검색(kube-dns)에서 사용할 Kubernetes 서비스 주소 범위 내의 IP 주소
    #docker_bridge_cidr = var.aks_docker_bridge_cidr # 노드에서 Docker 브리지 IP 주소로 사용되는 IP 주소
    service_cidr       = var.aks_service_cidr # Kubernetes 서비스에서 사용하는 네트워크 범위

    # outbound_type = "userAssignedNATGateway"
    # nat_gateway_profile {
    #   idle_timeout_in_minutes = 4 # 클러스터 로드 밸런서에 대해 원하는 아웃바운드 흐름 유휴 제한 시간(분)
    # }
  }

  role_based_access_control_enabled = true # Kubernetes 클러스터에 대한 역할 기반 액세스 제어를 활성화해야 하는지 여부. 기본값 true

  tags = {
    "Name" = "${var.tags}-aks"
  }
}