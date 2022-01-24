resource "azurerm_kubernetes_cluster" "aks-webapi" {
  name                = "aks-webapi-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location            = var.rg-location
  resource_group_name = var.rg-name
  dns_prefix          = "aks-webapi-${var.customer-name}-${var.env}"
  private_cluster_enabled = true
  sku_tier            = "Paid"
  node_resource_group = "rg-aksnode-webapi-${var.customer-name}-${var.env}-${var.location-prefix}-01"

  default_node_pool {
    name       = "system"
    node_count = 3
    max_pods   = 20
    os_disk_size_gb = 128
    os_disk_type = "Managed"
    availability_zones = [1, 2, 3]
    vm_size    = var.aks-default-np-vm-size
    vnet_subnet_id = var.subnet-id
    type           = "VirtualMachineScaleSets" 
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
    outbound_type     = "userDefinedRouting"  
    dns_service_ip     = "172.23.156.10"
    docker_bridge_cidr = "172.17.0.1/24"
    service_cidr       = "172.23.156.0/22" 
  }

  addon_profile {

    azure_policy {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.la-workspace-resource-id
    }  
  }

  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "webapi-user-np" {
  name                  = "workload01"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-webapi.id
  vm_size               = var.aks-user-np-vm-size
  node_count            = 10
  enable_auto_scaling   = true
  min_count             = 10
  max_count             = 15
  vnet_subnet_id        = var.subnet-id
  availability_zones    = [1, 2, 3]
  max_pods              = 10
  os_disk_size_gb = 128
  os_disk_type = "Ephemeral"

  node_taints = ["workload=webapi:NoSchedule"]
  node_labels = {"workload"="webapi"}

  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
