resource "azurerm_private_dns_zone" "fanid-mysql-dns" {
  name                = "fanid-${var.env}.mysql.database.azure.com"
  resource_group_name = var.rg-name
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_private_dns_zone_virtual_network_link" "fanid-vnet-link" {
  name                  = "fanidvnetzone.com"
  private_dns_zone_name = azurerm_private_dns_zone.fanid-mysql-dns.name
  virtual_network_id    = var.vnet-id
  resource_group_name   = var.rg-name
}

resource "azurerm_mysql_flexible_server" "fanid-mysql-svr" {
  name                = "${var.customer-name}-${var.env}-mysql-${var.location-prefix}-01"
  location            = var.rg-location
  geo_redundant_backup_enabled=true
  resource_group_name = var.rg-name
  administrator_login    =  var.mysql-userid
  administrator_password =  var.mysql-password
  backup_retention_days  = 7
  delegated_subnet_id    = var.mysql-subnet-id
  private_dns_zone_id    = azurerm_private_dns_zone.fanid-mysql-dns.id
  sku_name               = var.mysql-sku 

  high_availability {
    mode = "ZoneRedundant"
  }
  
  storage {
    auto_grow_enabled = true
  }
  
  depends_on = [azurerm_private_dns_zone_virtual_network_link.fanid-vnet-link]
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
