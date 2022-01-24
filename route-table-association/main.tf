resource "azurerm_subnet_route_table_association" "aks-webapi-subnet-to-route-table" {
  subnet_id      = var.aks-webapi-subnet-id
  route_table_id = var.route-table-id
}

resource "azurerm_subnet_route_table_association" "aks-svcbr-subnet-to-route-table" {
  subnet_id      = var.aks-svcbr-subnet-id
  route_table_id = var.route-table-id
}

resource "azurerm_subnet_route_table_association" "aks-bo-subnet-to-route-table" {
  subnet_id      = var.aks-bo-subnet-id
  route_table_id = var.route-table-id
}

resource "azurerm_subnet_route_table_association" "aks-chatbot-subnet-to-route-table" {
  subnet_id      = var.aks-chatbot-subnet-id
  route_table_id = var.route-table-id
}

resource "azurerm_subnet_route_table_association" "aks-ibmmw-subnet-to-route-table" {
  subnet_id      = var.aks-ibmmw-subnet-id
  route_table_id = var.route-table-id
}

resource "azurerm_subnet_route_table_association" "aks-liferay-subnet-to-route-table" {
  subnet_id      = var.aks-liferay-subnet-id
  route_table_id = var.route-table-id
}
