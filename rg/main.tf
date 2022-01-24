resource "azurerm_resource_group" "webapi-rg" {
  name     = "rg-webapi-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "svcbr-rg" {
  name     = "rg-svcbr-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "bo-rg" {
  name     = "rg-bo-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "chatbot-rg" {
  name     = "rg-chatbot-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "ibmmw-rg" {
  name     = "rg-ibmmw-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "liferay-rg" {
  name     = "rg-liferay-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_resource_group" "mysql-rg" {
  name     = "rg-mysqlflexi-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location = var.location
  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
