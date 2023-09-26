# - VNET with at least one subnet

resource "azurerm_resource_group" "vnet_rg" {
  name     = var.vnet_rg_name
  location = var.vnet_rg_location
}

resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  address_space       = var.vnet_address_space
  dns_servers         = var.vnet_dns_servers
}

resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = var.subnet_address_space
}

resource "azurerm_subnet_network_security_group_association" "nsg_snet_association" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_network_security_rule" "ssh_inbound_myIP" {
  name                        = "SSHInboundMyIP"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "85.252.215.82"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vnet_rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}

resource "azurerm_network_security_rule" "allow_internal_traffic" {
  name                        = "AllowInternalTraffic"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "10.0.0.0/16"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.vnet_rg.name
  network_security_group_name = azurerm_network_security_group.nsg.name
}