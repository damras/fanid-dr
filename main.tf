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
    env                   = var.env
    createdby             = var.createdby
    creationdate          = var.creationdate
}

module "vnet" {
    source                = "./vnet"
    rg-name               = var.vnet-rg-name
    rg-location           = var.location
    vnet-name             = var.vnet-name
    customer-name         = var.customer-name
    env                   = var.env
    createdby             = var.createdby
    creationdate          = var.creationdate
    aks-webapi-subnet-address-space  = var.aks-webapi-subnet-address-space
    aks-svc-subnet-address-space  = var.aks-svc-subnet-address-space
    mysql-subnet-address-space = var.mysql-subnet-address-space
}

module "route-table" {
    source               = "./route-table"
    rg-name              = var.vnet-rg-name
    rg-location          = var.location
    vnet-address-space    = var.vnet-address-space
    firewall-private-ip  = var.firewall-private-ip
    env                   = var.env
    createdby             = var.createdby
    creationdate          = var.creationdate
}

module "route-table-association" {
   source                = "./route-table-association" 
   route-table-id        = module.route-table.route-table-id 
   aks-webapi-subnet-id         = module.vnet.aks-webapi-subnet-id
   aks-svc-subnet-id         = module.vnet.aks-svc-subnet-id
}

module "aks" {
   source                = "./aks"
   env                   = var.env
   createdby             = var.createdby
   creationdate          = var.creationdate
   customer-name         = var.customer-name
   webapi-rg-name               = module.rg.webapi-rg-name
   svccenter-rg-name               = module.rg.svccenter-rg-name
   rg-location           = var.location
   aks-webapi-subnet-id         = module.vnet.aks-webapi-subnet-id
   aks-svc-subnet-id         = module.vnet.aks-svc-subnet-id
   la-workspace-resource-id = var.la-workspace-resource-id
   aks-default-np-vm-size           = var.aks-default-np-vm-size
   aks-user-np-vm-size           = var.aks-user-np-vm-size
   depends_on            = [module.route-table-association]
}

module "mysql" {
   source                = "./mysql"
   env                   = var.env
   createdby             = var.createdby
   creationdate          = var.creationdate
   customer-name         = var.customer-name
   rg-location           = var.location
   rg-name               = module.rg.mysql-rg-name
   vnet-id               = var.vnet-id
   mysql-subnet-address-space = var.mysql-subnet-address-space
   mysql-subnet-id       = module.vnet.mysql-subnet-id
   mysql-userid          = var.mysql-userid
   mysql-password        = var.mysql-password
   mysql-sku             = var.mysql-sku
}
