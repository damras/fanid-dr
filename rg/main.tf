resource "azurerm_resource_group" "webapi-rg" {
  name     = "rg-webapi-${var.customer-name}-${var.env}-we-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "svccenter-rg" {
  name     = "rg-svccenter-${var.customer-name}-${var.env}-we-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "mysql-rg" {
  name     = "rg-mysqlflexi-${var.customer-name}-${var.env}-we-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
