# main.tf 파일에서 사용하려는 변수를 선언하는 파일

variable "st_access_key" {
}

variable "agent_count" {
  default = 3
}

variable "aks_service_principal_app_id" {
  default = ""
}

variable "aks_service_principal_client_secret" {
  default = ""
}

variable "cluster_name" {
  default = "nodamenk8sdemo"
}

variable "dns_prefix" {
  default = "nodamenk8sdemo"
}

# https://azure.microsoft.com/ko-kr/explore/global-infrastructure/products-by-region/?products=monitor (로그 분석 사용 가능 지역 URL)
variable "log_analytics_workspace_location" {
  default = "koreacentral"
}

variable "log_analytics_workspace_name" {
  default = "testLogAnalyticsWorkspaceName"
}

# https://azure.microsoft.com/ko-kr/pricing/details/monitor/ (로그 분석 가격 URL)
variable "log_analytics_workspace_sku" {
  default = "PerGB2018"
}

variable "resource_group_name" {
  default = "rg-azure-k8sdemo"
}

variable "location" {
  default = "Korea Central"
}

variable "resource_group_location" {
  default     = "koreacentral"
  description = "Location of the resource group."
}

# variable "resource_group_name_prefix" {
#   default     = "rg"
#   description = "Prefix of the resource group name that's combined with a random ID so name is unique in your Azure subscription."
# }

variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}



