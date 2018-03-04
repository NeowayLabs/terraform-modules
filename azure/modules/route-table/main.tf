provider "azurerm" {
  version = "~> 1.1"
}

resource "azurerm_route_table" "route_table" {
  name                = "${var.route_table_name}"
  location            = "${var.location}"
  resource_group_name = "${var.vnet_resource_group}"
  tags                = "${var.tags}"
}

#############################
#  Routes                   #
#############################

resource "azurerm_route" "routes" {
  count                       = "${length(var.routes)}"
  name                        = "${lookup(var.routes[count.index], "name")}"
  address_prefix              = "${lookup(var.routes[count.index], "address_prefix")}"
  next_hop_type               = "${lookup(var.routes[count.index], "next_hop_type")}"
  next_hop_in_ip_address      = "${lookup(var.routes[count.index], "next_hop_in_ip_address")}"
  resource_group_name         = "${var.vnet_resource_group}"
  route_table_name            = "${azurerm_route_table.route_table.name}"
}
