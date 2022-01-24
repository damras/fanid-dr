resource "azurerm_kubernetes_cluster" "aks-liferay" {
  name                = "aks-liferay-${var.customer-name}-${var.env}-${var.location-prefix}-01"
  location            = var.rg-location
  resource_group_name = var.rg-name
  dns_prefix          = "aks-liferay-${var.customer-name}-${var.env}"
  private_cluster_enabled = true
  sku_tier            = "Paid"
  node_resource_group = "rg-aksnode-liferay-${var.customer-name}-${var.env}-${var.location-prefix}-01"

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

resource "azurerm_kubernetes_cluster_node_pool" "liferay-dr-np" {
  name                  = "liferaydr01"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-liferay.id
  vm_size               = "Standard_D32ds_v4"
  node_count            = 8
  enable_auto_scaling   = true
  min_count             = 8
  max_count             = 10
  vnet_subnet_id        = var.subnet-id
  availability_zones    = [1, 2, 3]
  max_pods              = 10
  os_disk_size_gb = 128
  os_disk_type = "Ephemeral"

  node_taints = ["workload=liferay:NoSchedule"]
  node_labels = {"workload"="liferay"}

  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "lre-dr-np" {
  name                  = "lredr01"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks-liferay.id
  vm_size               = "Standard_D16ds_v4"
  node_count            = 3
  enable_auto_scaling   = false
  vnet_subnet_id        = var.subnet-id
  availability_zones    = [1, 2, 3]
  max_pods              = 10
  os_disk_size_gb = 128
  os_disk_type = "Ephemeral"

  node_taints = ["workload=elasticsearch:NoSchedule"]
  node_labels = {"workload"="elasticsearch"}

  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
