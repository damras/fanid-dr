resource "azurerm_container_registry" "acr" {
  name                = "acr${var.customer-name}${var.env}${var.location-prefix}02"
  resource_group_name = "${var.rg-name}"
  location            = "${var.rg-location}"
  sku                 = "Premium"
  admin_enabled       = true
  georeplications = [
    {
      regional_endpoint_enabled = true 
      location                = "westeurope"
      zone_redundancy_enabled = true
      tags                    = {}
  }]

  tags = {
    Environment  = "${var.env}",
    CreatedBy    = "${var.createdby}",
    CreationDate = "${var.creationdate}"
  }
}


resource "azurerm_private_dns_zone" "acr-private-dns-zone" {
  name                = "privatelink.azurecr.io"
  resource_group_name = var.rg-name

  tags = {
    Environment  = "${var.env}",
    CreatedBy    = "${var.createdby}",
    CreationDate = "${var.creationdate}"
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "acr-private-vnet-link" {
  name                  = "acr-private-vnet-link"
  resource_group_name   = var.rg-name
  private_dns_zone_name = azurerm_private_dns_zone.acr-private-dns-zone.name
  virtual_network_id    = var.vnet-id
}

resource "azurerm_private_endpoint" "acr-pe" {
  name                = "pe-acr-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location            = var.rg-location
  resource_group_name = var.rg-name
  subnet_id           = var.pe-subnet-id

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.acr-private-dns-zone.id]
  }

  private_service_connection {
    name                           = "acr-privateserviceconnection"
    private_connection_resource_id = azurerm_container_registry.acr.id
    subresource_names              = [ "registry" ]
    is_manual_connection           = false
  }

  tags = {
    Environment  = "${var.env}",
    CreatedBy    = "${var.createdby}",
    CreationDate = "${var.creationdate}"
  }
}

