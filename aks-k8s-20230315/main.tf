# Kubernetes 클러스터용 리소스를 선언하는 Terraform 구성 파일

resource "azurerm_resource_group" "k8s" {
  name = var.resource_group_name
  location = var.resource_group_location
}

resource "random_id" "log_analytics_workspace_name_suffix" {
  byte_length = 8
}

resource "azurerm_log_analytics_workspace" "test" {
  # WorkSpace 이름은 구독/테넌트뿐만 아니라 Azure 전체에서 고유해야 한다.
  name = "${var.log_analytics_workspace_name}-${random_id.log_analytics_workspace_name_suffix.dec}"
  location = var.log_analytics_workspace_location
  resource_group_name = azurerm_resource_group.k8s.name
  sku = var.log_analytics_workspace_sku
}

resource "azurerm_log_analytics_solution" "test" {
  solution_name = "ContainerInsights"
  location = azurerm_log_analytics_workspace.test.location
  resource_group_name = azurerm_resource_group.k8s.name
  workspace_resource_id = azurerm_log_analytics_workspace.test.id
  workspace_name = azurerm_log_analytics_workspace.test.name

  plan {
    publisher = "Microsoft"
    product = "OMSGallery/ContainerInsights"
  }
}

resource "azurerm_kubernetes_cluster" "k8s" {
    name = var.cluster_name
    location = azurerm_resource_group.k8s.location
    resource_group_name = azurerm_resource_group.k8s.name
    dns_prefix = var.dns_prefix # 쿠버네티스의 경우 다른 Pod를 찾을 시 동일 네임스페이스 안에서 찾을 때 PQDN을 사용하고, 네임스페이스 외부에서 찾을 때 FQDN을 사용한다.
    tags = {
      "Environment" = "Development"
    }

    # 워커 노드에 대한 세부 정보
    default_node_pool {
        name = "agentpool"
        node_count = var.agent_count
        vm_size = "standard_ds2_v2"
        # record 선언은 만들어낼 워커 노드 수와 워커 노드 유형이 포함된다. 나중에 클러스터를 확장하거나 축소해야 하는 경우, 이 레코드에서 count 값을 수정한다.
    }

    linux_profile {
      admin_username = "ubuntu"

      # SSH를 사용하여 워커 노드에 로그인할 수 있는 설정
      ssh_key {
        key_data = file(var.ssh_public_key) # 클러스테어 액세스하는 데 사용되는 공개 SSH 키
      }
    }

    network_profile {
        network_plugin    = "kubenet"
        load_balancer_sku = "standard"
    }

    service_principal {
    client_id     = var.aks_service_principal_app_id
    client_secret = var.aks_service_principal_client_secret
  }
    
    # Terraform 3.0 부터 addon_profile.oms_agent 변경사항이 있습니다.
    # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/3.0-upgrade-guide
    # oms_agent {
    #     log_analytics_workspace_id = azurerm_log_analytics_workspace.test.id
    # }
}

