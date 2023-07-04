# 이 변수는 재사용되기 때문에 locals 블록을 만들어 유지하기 쉽게한다.
locals {
  backend_address_pool_name      = "${var.agw_name}-beap" # 해당되는 블록의 사용되는 백엔드 주소 풀의 이름, redirect_configuration_name이 설정된 경우 설정할 수 없다. 
  frontend_port_name             = "${var.agw_name}-feport" # 해당되는 블록의 사용되는 프론트엔드 포트 이름
  frontend_ip_configuration_name = "${var.agw_name}-feip" # 해당되는 블록의 사용되는 프론트엔드 IP 구성의 이름
  http_setting_name              = "${var.agw_name}-be-htst" # 해당되는 블록의 사용되는 http setting 이름
  listener_name                  = "${var.agw_name}-httplstn" # 해당되는 블록의 사용되는 수신기 이름
  request_routing_rule_name      = "${var.agw_name}-rqrt" # 해당되는 블록의 사용되는 요청 라우팅 규칙 이름
  redirect_configuration_name    = "${var.agw_name}-rdrcfg" # 해당되는 블록의 사용되는 리다이렉션 구성 이름, backend_address_pool_name or backend_http_settings_name이 설정된 경우 설정할 수 없다.
  gateway_ip_configuration_name  = "${var.agw_name}-gic" # 해당되는 게이트웨이 IP 구성의 이름
}

resource "azurerm_application_gateway" "agw" {
  name = "agw-${var.agw_name}"
  resource_group_name = var.resource_group_name
  location = var.resource_gorup_location

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name = local.gateway_ip_configuration_name
    subnet_id = var.subnet_id # Application Gateway를 연결해야 하는 서브넷 ID, ex) azurerm_subnet.frontend.id
  }

  frontend_port {
    name = "${local.frontend_port_name}-http"
    port = 80
  }

  frontend_port {
    name     = "hubVnet0329-feport-https"
    port     = 443
  }

  frontend_ip_configuration {
    name = local.frontend_ip_configuration_name
    public_ip_address_id = var.public_ip_address_id # Application Gateway에서 사용해야 하는 공용 IP 주소의 ID, ex) azurerm_public_ip.example.id
  }

  backend_address_pool {
    name = local.backend_address_pool_name
  }

  backend_http_settings {
    name = local.http_setting_name
    cookie_based_affinity = "Disabled"
    #path = "" # 모든 HTTP 요청의 접두사로 사용해야 하는 경로
    port = 80
    protocol = "Http" # 사용해야 하는 프로토콜. Http or Https
    request_timeout = 60 # 요청 제한 시간(초). 1 ~ 86400초 사이. 기본값은 30
  }

  http_listener {
    name = local.listener_name
    frontend_ip_configuration_name = local.frontend_ip_configuration_name
    frontend_port_name = "${local.frontend_port_name}-http"
    protocol = "Http"
  }

  request_routing_rule {
    name = local.request_routing_rule_name
    rule_type = "Basic"
    http_listener_name = local.listener_name
    backend_address_pool_name = local.backend_address_pool_name
    backend_http_settings_name = local.http_setting_name
    priority = var.request_routing_rule_priority
  }

  tags = {
      Name = "${var.tags}-agw"
  }
}