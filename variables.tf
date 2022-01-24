variable "customer-name" {}
variable "location" {}
variable "location-prefix" {}
variable "env" {}
variable "createdby" {}
variable "creationdate" {}

variable "aks-chatbot-subnet-address-space" {}
variable "aks-ibmmw-subnet-address-space" {}
variable "aks-bo-subnet-address-space" {}
variable "aks-liferay-subnet-address-space" {}
variable "aks-webapi-subnet-address-space" {}
variable "aks-svcbr-subnet-address-space" {}
variable "pe-subnet-address-space" {}
variable "netapp-liferay-subnet-address-space" {}
variable "netapp-bo-subnet-address-space" {}
variable "sqlmi-orbis-subnet-address-space" {}
variable "apps-orbis-subnet-address-space" {}
variable "sqlmi-chatbot-subnet-address-space" {}
variable "redis-bo-subnet-address-space" {}
variable "mysql-subnet-address-space" {}


######## ADDRESS RANGE FOR PRODUCTION VNET AND SUBNETS ######
variable "vnet-address-space" {}
################ LOG ANALYTICS WORKSPACE ##################

variable "la-log-retention-in-days" {
  type   =  number
  default =  30
}

################ Kubernetes ###############################
variable "aks-default-np-vm-size" {}
variable "aks-user-np-vm-size" {}
variable "firewall-private-ip" {}
variable "la-workspace-resource-id" {
}

variable "vnet-rg-name" {
}

variable "vnet-name" { 
}

variable "vnet-id" {
}

variable "mysql-userid" {
} 

variable "sql-server-admin-user" {}
variable "sql-server-admin-password" {}

variable "mysql-password" {
}

variable "mysql-sku" {
}

