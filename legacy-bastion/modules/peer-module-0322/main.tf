resource "azurerm_virtual_network_peering" "peer" {
  name = "${var.virtual_network_origin_name}-to-${var.virtual_network_edge_name}"
  resource_group_name = var.resource_group_name
  virtual_network_name = var.virtual_network_origin_name # 오리진 가상 네트워크의 리소스 이름
  remote_virtual_network_id = var.remote_virtual_network_edge_id # 원격(엣지) 가상 네트워크의 전체 Azure 리소스 ID
  allow_virtual_network_access = true # 원격 가상 네트워크의 VM이 로컬 가상 네트워크의 VM에 액세스할 수 있는지 여부
  allow_forwarded_traffic      = true # 원격 가상 네트워크의 VM에서 전달된 트래픽이 허용되는지 여부
  allow_gateway_transit        = false # 로컬 가상 네트워크에 대한 원격 가상 네트워크의 링크에서 gatewayLinks를 사용할 수 있는지 여부
  use_remote_gateways          = false # 로컬 가상 네트워크에서 원격 게이트웨이를 사용할 수 있는지 여부. 원격 가상 네트워크 피어링에서도 allow_gateway_transit이 true일 때,
                                       # 가상 네트워크는 전송을 위해 원격 가상 네트워크의 게이트웨이를 사용한다.
}

# origin: vnet 연결할 때 출발지
# edge: vnet 연결할 때 도착지