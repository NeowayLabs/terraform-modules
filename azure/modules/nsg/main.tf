provider "azurerm" {
  version = "~> 1.9.0"
}

resource "azurerm_network_security_group" "nsg" {
  name                = "${var.security_group_name}"
  location            = "${var.location}"
  resource_group_name = "${var.vnet_resource_group}"
  tags                = "${var.tags}"
}

#############################
#  Security rules           #
#############################

resource "azurerm_network_security_rule" "rules" {
  count                       = "${length(var.rules)}"
  name                        = "${lookup(var.rules[count.index], "name")}"
  priority                    = "${lookup(var.rules[count.index], "priority")}"
  direction                   = "${lookup(var.rules[count.index], "direction")}"
  access                      = "${lookup(var.rules[count.index], "access")}"
  protocol                    = "${lookup(var.rules[count.index], "protocol")}"
  source_port_range           = "${lookup(var.rules[count.index], "source_port_range")}"
  destination_port_range      = "${lookup(var.rules[count.index], "destination_port_range")}"
  source_address_prefix       = "${lookup(var.rules[count.index], "source_address_prefix")}"
  destination_address_prefix  = "${lookup(var.rules[count.index], "destination_address_prefix")}"
  description                 = "${lookup(var.rules[count.index], "description")}"
  resource_group_name         = "${var.vnet_resource_group}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
