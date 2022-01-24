resource "azurerm_mssql_server" "sql-server" {
  name                         = "sql-transactions-fanid-dr-ne-01"
  resource_group_name          = var.rg-name
  location                     = var.rg-location
  version                      = "12.0"
  administrator_login          = var.sql-server-admin-user
  administrator_login_password = var.sql-server-admin-password
}

resource "azurerm_mssql_database" "middlewaredb" {
  name           = "HCEPDRMWDB"
  server_id      = azurerm_mssql_server.sql-server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 500
  read_scale     = true
  sku_name       = "BC_Gen5_4"
  zone_redundant = true
}

resource "azurerm_mssql_database" "bodb" {
  name           = "HCEPDRBODB"
  server_id      = azurerm_mssql_server.sql-server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 512
  read_scale     = true
  sku_name       = "BC_M_8"
  zone_redundant = true
}

resource "azurerm_mssql_database" "ticketingdrdb" {
  name           = "ticketingdrdb"
  server_id      = azurerm_mssql_server.sql-server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = 244
  read_scale     = true
  sku_name       = "BC_Gen5_2"
  zone_redundant = true
}

resource "azurerm_private_dns_zone" "db-private-dns-zone" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.rg-name
}

resource "azurerm_private_dns_zone_virtual_network_link" "db-private-vnet-link" {
  name                  = "mssql-to-vnet-link"
  resource_group_name   = var.rg-name
  private_dns_zone_name = azurerm_private_dns_zone.db-private-dns-zone.name
  virtual_network_id    = var.vnet-id
}

resource "azurerm_private_endpoint" "sqlserver-pe" {
  name                = "pe-sqlserver"
  location            = var.rg-location
  resource_group_name = var.rg-name
  subnet_id           = var.pe-subnet-id

  private_dns_zone_group {
    name                 = "private-dns-zone-group"
    private_dns_zone_ids = [azurerm_private_dns_zone.db-private-dns-zone.id]
  }

  private_service_connection {
    name                           = "sqlsvr-privateserviceconnection"
    private_connection_resource_id = azurerm_mssql_server.sql-server.id
    subresource_names              = [ "sqlServer" ]
    is_manual_connection           = false
  }
}
