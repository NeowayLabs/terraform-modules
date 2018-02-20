resource "azurerm_resource_group" "nsg" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.nsg_name}"
  location            = "${azurerm_resource_group.nsg.location}"
  resource_group_name = "${azurerm_resource_group.nsg.name}"
}

resource "azurerm_network_security_rule" "denyinboundall" {
  name                        = "deny-inbound-all"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.nsg.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
