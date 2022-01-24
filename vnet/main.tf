resource "azurerm_virtual_network" "fanid-dr-vnet" {
  name                = "vnet-fanid-dr-ne-001"
  location            = "northeurope"
  resource_group_name = var.rg-name
  address_space       = ["172.23.112.0/20"]

 tags = {
    environment = "Hub"
  }
}


resource "azurerm_subnet" "aks-chatbot-subnet" {
  name                 = "snet-aks-chatbot-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.aks-chatbot-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "aks-ibmmw-subnet" {
  name                 = "snet-aks-ibmmw-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.aks-ibmmw-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}


resource "azurerm_subnet" "aks-bo-subnet" {
  name                 = "snet-aks-bo-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.aks-bo-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "aks-liferay-subnet" {
  name                 = "snet-aks-liferay-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.aks-liferay-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "aks-webapi-subnet" {
  name                 = "snet-aks-webapi-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.aks-webapi-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "aks-svcbr-subnet" {
  name                 = "snet-aks-svcbr-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.aks-svcbr-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "pe-subnet" {
  name                 = "snet-pe-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.pe-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "netapp-liferay-subnet" {
  name                 = "snet-netapp-liferay-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.netapp-liferay-subnet-address-space]
}

resource "azurerm_subnet" "netapp-bo-subnet" {
  name                 = "snet-netapp-bo-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.netapp-bo-subnet-address-space]
}

resource "azurerm_subnet" "sqlmi-orbis-subnet" {
  name                 = "snet-sqlmi-orbis-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.sqlmi-orbis-subnet-address-space]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  }
}

resource "azurerm_subnet" "apps-orbis-subnet" {
  name                 = "snet-apps-orbis-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.apps-orbis-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "sqlmi-chatbot-subnet" {
  name                 = "snet-sqlmi-chatbot-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.sqlmi-chatbot-subnet-address-space]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name    = "Microsoft.Sql/managedInstances"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action", "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action", "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
    }
  } 
}

resource "azurerm_subnet" "redis-bo-subnet" {
  name                 = "snet-redis-bo-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.redis-bo-subnet-address-space]
  enforce_private_link_endpoint_network_policies = true
  enforce_private_link_service_network_policies  = true
}

resource "azurerm_subnet" "mysql-subnet" {
  name                 = "snet-mysql-${var.customer-name}-${var.env}-we-01"
  resource_group_name  = var.rg-name
  virtual_network_name = var.vnet-name
  address_prefixes     = [var.mysql-subnet-address-space]

  service_endpoints    = ["Microsoft.Storage"]
  delegation {
    name = "fs"
    service_delegation {
      name = "Microsoft.DBforMySQL/flexibleServers"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
      ]
    }
  }
}
