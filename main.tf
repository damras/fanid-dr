# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.91"
    }
  }
  
  required_version = ">= 1.0"
}

provider "azurerm" {
  features {
   }
}

data "azurerm_client_config" "current" {}

output "current_client_id" {
  value = data.azurerm_client_config.current.client_id
}

output "current_tenant_id" {
  value = data.azurerm_client_config.current.tenant_id
}

output "current_subscription_id" {
  value = data.azurerm_client_config.current.subscription_id
}

output "current_object_id" {
  value = data.azurerm_client_config.current.object_id
}

module "rg" {
    source                = "./rg"
    customer-name         = var.customer-name
    location              = var.location
    location-prefix       = var.location-prefix
    env                   = var.env
    createdby             = var.createdby
    creationdate          = var.creationdate
}

module "vnet" {
    source                                  = "./vnet"
    rg-name                                 = var.vnet-rg-name
    rg-location                             = var.location
    location-prefix                         = var.location-prefix
    vnet-name                               = var.vnet-name
    customer-name                           = var.customer-name
    env                                     = var.env
    createdby                               = var.createdby
    creationdate                            = var.creationdate
    aks-bo-subnet-address-space             = var.aks-bo-subnet-address-space
    aks-chatbot-subnet-address-space        = var.aks-chatbot-subnet-address-space
    aks-ibmmw-subnet-address-space          = var.aks-ibmmw-subnet-address-space
    aks-liferay-subnet-address-space        = var.aks-liferay-subnet-address-space
    aks-svcbr-subnet-address-space          = var.aks-svcbr-subnet-address-space
    aks-webapi-subnet-address-space         = var.aks-webapi-subnet-address-space
    apps-orbis-subnet-address-space         = var.apps-orbis-subnet-address-space
    mysql-subnet-address-space              = var.mysql-subnet-address-space
    pe-subnet-address-space                 = var.pe-subnet-address-space
    netapp-liferay-subnet-address-space     = var.netapp-liferay-subnet-address-space
    netapp-bo-subnet-address-space          = var.netapp-bo-subnet-address-space
    sqlmi-chatbot-subnet-address-space      = var.sqlmi-chatbot-subnet-address-space
    sqlmi-orbis-subnet-address-space        = var.sqlmi-orbis-subnet-address-space
    redis-bo-subnet-address-space           = var.redis-bo-subnet-address-space
} 

module "route-table" {
    source                   = "./route-table"
    rg-name                  = var.vnet-rg-name
    rg-location              = var.location
    vnet-address-space       = var.vnet-address-space
    firewall-private-ip      = var.firewall-private-ip
    env                      = var.env
    createdby                = var.createdby
    creationdate             = var.creationdate
}

module "route-table-association" {
   source                    = "./route-table-association" 
   route-table-id            = module.route-table.route-table-id 
   aks-bo-subnet-id          = module.vnet.aks-bo-subnet-id
   aks-chatbot-subnet-id     = module.vnet.aks-chatbot-subnet-id
   aks-ibmmw-subnet-id       = module.vnet.aks-ibmmw-subnet-id
   aks-liferay-subnet-id     = module.vnet.aks-liferay-subnet-id
   aks-svcbr-subnet-id       = module.vnet.aks-svcbr-subnet-id
   aks-webapi-subnet-id      = module.vnet.aks-webapi-subnet-id
   depends_on                = [module.route-table,module.vnet]
}

module "aks-liferay" {
   source                    = "./aks-liferay"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   location-prefix           = var.location-prefix
   rg-name                   = module.rg.liferay-rg-name
   rg-location               = var.location
   aks-default-np-vm-size    = var.aks-default-np-vm-size
   la-workspace-resource-id  = var.la-workspace-resource-id
   subnet-id                 = module.vnet.aks-liferay-subnet-id
   depends_on                = [module.route-table-association]
}

module "aks-bo" {
   source                    = "./aks-bo"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   location-prefix           = var.location-prefix
   rg-name                   = module.rg.bo-rg-name
   rg-location               = var.location
   aks-default-np-vm-size    = var.aks-default-np-vm-size
   la-workspace-resource-id  = var.la-workspace-resource-id
   subnet-id                 = module.vnet.aks-bo-subnet-id
   depends_on                = [module.route-table-association]
}

module "aks-svcbr" {
   source                    = "./aks-svcbr"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   location-prefix           = var.location-prefix
   rg-name                   = module.rg.svcbr-rg-name
   rg-location               = var.location
   aks-default-np-vm-size    = var.aks-default-np-vm-size
   aks-user-np-vm-size       = var.aks-user-np-vm-size
   la-workspace-resource-id  = var.la-workspace-resource-id
   subnet-id                 = module.vnet.aks-svcbr-subnet-id
   depends_on                = [module.route-table-association]
}

module "aks-webapi" {
   source                    = "./aks-webapi"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   location-prefix           = var.location-prefix
   rg-name                   = module.rg.webapi-rg-name
   rg-location               = var.location
   aks-default-np-vm-size    = var.aks-default-np-vm-size
   aks-user-np-vm-size       = var.aks-user-np-vm-size
   la-workspace-resource-id  = var.la-workspace-resource-id
   subnet-id                 = module.vnet.aks-webapi-subnet-id
   depends_on                = [module.route-table-association]
}

module "aks-ibmmw" {
   source                    = "./aks-ibmmw"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   location-prefix           = var.location-prefix
   rg-name                   = module.rg.ibmmw-rg-name
   rg-location               = var.location
   aks-default-np-vm-size    = var.aks-default-np-vm-size
   aks-user-np-vm-size       = var.aks-user-np-vm-size
   la-workspace-resource-id  = var.la-workspace-resource-id
   subnet-id                 = module.vnet.aks-ibmmw-subnet-id
   depends_on                = [module.route-table-association]
}

module "aks-chatbot" {
   source                    = "./aks-chatbot"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   location-prefix           = var.location-prefix
   rg-name                   = module.rg.chatbot-rg-name
   rg-location               = var.location
   aks-default-np-vm-size    = var.aks-default-np-vm-size
   aks-user-np-vm-size       = var.aks-user-np-vm-size
   la-workspace-resource-id  = var.la-workspace-resource-id
   subnet-id                 = module.vnet.aks-chatbot-subnet-id
   depends_on                = [module.route-table-association]
}

module "mysql" {
   source                    = "./mysql"
   env                       = var.env
   createdby                 = var.createdby
   creationdate              = var.creationdate
   customer-name             = var.customer-name
   rg-location               = var.location
   rg-name                   = module.rg.mysql-rg-name
   location-prefix           = var.location-prefix
   vnet-id                   = var.vnet-id
   mysql-subnet-address-space = var.mysql-subnet-address-space
   mysql-subnet-id           = module.vnet.mysql-subnet-id
   mysql-userid              = var.mysql-userid
   mysql-password            = var.mysql-password
   mysql-sku                 = var.mysql-sku
}
