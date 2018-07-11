provider "azurerm" {
  version = "~> 1.8"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "${var.vnet_name}"
  location            = "${var.location}"
  address_space       = "${var.address_space}"
  resource_group_name = "${var.resource_group_name}"
  dns_servers         = "${var.dns_servers}"
  tags                = "${var.tags}"
}

resource "azurerm_subnet" "subnet" {
  name                      = "${var.subnet_names[count.index]}"
  virtual_network_name      = "${azurerm_virtual_network.vnet.name}"
  resource_group_name       = "${var.resource_group_name}"
  address_prefix            = "${var.subnet_address_prefixes[count.index]}"
  network_security_group_id = "${lookup(var.nsg_ids,var.subnet_names[count.index],"")}"
  route_table_id            = "${lookup(var.route_table_ids,var.subnet_names[count.index],"")}"
  count                     = "${length(var.subnet_names)}"
}
