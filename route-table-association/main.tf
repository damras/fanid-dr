resource "azurerm_subnet_route_table_association" "aks-webapi-subnet-to-route-table" {
  subnet_id      = var.aks-webapi-subnet-id
  route_table_id = var.route-table-id
}

resource "azurerm_subnet_route_table_association" "aks-svc-subnet-to-route-table" {
  subnet_id      = var.aks-svc-subnet-id
  route_table_id = var.route-table-id
}
