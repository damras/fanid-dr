resource "azurerm_route_table" "rt-dr-hub-firewall" {
  name                          = "rt-dr-hub-firewall-001"
  location                      = var.rg-location
  resource_group_name           = var.rg-name
  disable_bgp_route_propagation = false

#  route {
#    name                        = "route_internal_traffic_in_vnet"
#    address_prefix              = var.vnet-address-space
#    next_hop_type               = "VnetLocal"
#  }

  route {
    name                        = "route_all_traffic_to_fw"
    address_prefix              = "0.0.0.0/0"
    next_hop_type               = "VirtualAppliance"
    next_hop_in_ip_address      = var.firewall-private-ip
  }

  tags = {
    Environment  = var.env,
    CreatedBy    = var.createdby,
    CreationDate = var.creationdate
  }
}
