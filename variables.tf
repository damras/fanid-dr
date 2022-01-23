variable "customer-name" {}
variable "location" {}
variable "location-prefix" {}
variable "env" {}
variable "createdby" {}
variable "creationdate" {}

######## ADDRESS RANGE FOR PRODUCTION VNET AND SUBNETS ######
variable "vnet-address-space" {}
variable "aks-webapi-subnet-address-space" {}
variable "aks-svc-subnet-address-space" {}
variable "mysql-subnet-address-space" {}
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

variable "mysql-password" {
}

variable "mysql-sku" {
}

###############  END ######################################
