output "aks-webapi-subnet-id" { 
   value = azurerm_subnet.aks-webapi-subnet.id
}

output "aks-svcbr-subnet-id" { 
   value = azurerm_subnet.aks-svcbr-subnet.id
}

output "aks-chatbot-subnet-id" { 
   value = azurerm_subnet.aks-chatbot-subnet.id
}

output "aks-bo-subnet-id" { 
   value = azurerm_subnet.aks-bo-subnet.id
}

output "aks-liferay-subnet-id" { 
   value = azurerm_subnet.aks-liferay-subnet.id
}

output "aks-ibmmw-subnet-id" { 
   value = azurerm_subnet.aks-ibmmw-subnet.id
}

output "mysql-subnet-id" { 
   value = azurerm_subnet.mysql-subnet.id
}
