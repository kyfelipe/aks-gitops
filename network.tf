resource "azurerm_virtual_network" "vnet" {
  name                = local.config.vnet.name
  resource_group_name = azurerm_resource_group.conductor.name
  location            = azurerm_resource_group.conductor.location
  address_space       = local.config.vnet.address_space
  dns_servers         = local.config.vnet.dns_servers
}

resource "azurerm_subnet" "subnet" {
  name                 = local.config.vnet.subnet.name
  resource_group_name  = azurerm_resource_group.conductor.name
  address_prefixes     = local.config.vnet.subnet.address_prefixes
  virtual_network_name = azurerm_virtual_network.vnet.name
  service_endpoints    = local.config.vnet.subnet.service_endpoints
}

resource "azurerm_network_security_group" "inbound" {
  name                = "allowInbound"
  location            = azurerm_resource_group.conductor.location
  resource_group_name = azurerm_resource_group.conductor.name

  security_rule {
    name                       = "all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "allow" {
  subnet_id                 = azurerm_subnet.subnet.id
  network_security_group_id = azurerm_network_security_group.inbound.id
}
