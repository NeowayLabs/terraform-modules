resource "azurerm_resource_group" "network" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

module "vnet" {
  source              = "../../modules/vnet"
  vnet_name           = "${var.vnet_name}"
  resource_group_name = "${azurerm_resource_group.network.name}"
  location            = "${var.location}"
  address_space       = "${var.address_space}"
  dns_servers         = "${var.dns_servers}"
  subnet_prefixes     = "${var.subnet_prefixes}"
  subnet_names        = "${var.subnet_names}"
  tags                = "${var.tags}"

  /* TODO how do it?
  nsg_ids             = {
                          test-subnet1 = "${module.nsg1.network_security_group_id}"
                          test-subnet2 = "${module.nsg2.network_security_group_id}"
                        }
  route_table_ids     = {
                          test-subnet1 = "${module.rt1.route_table_id}"
                          test-subnet2 = "${module.rt2.route_table_id}"
                        }
  */
}

module "nsg" {
  source              = "../../modules/nsg"
  resource_group_name = "${azurerm_resource_group.network.name}"
  location            = "${var.location}"
  security_group_name = "${var.nsg_names[count.index]}"
  rules               = "${lookup(var.nsg_names[count.index], "nsg_rules")}"
  count               = "${length(var.nsg_names)}"
}

module "route-table" {
  source              = "../../modules/nsg"
  resource_group_name = "${azurerm_resource_group.network.name}"
  location            = "${var.location}"
  route_table_name    = "${var.route_table_names[count.index]}"
  routes              = "${lookup(var.route_table_names[count.index], "route_table_routes")}"
  count               = "${length(var.route_table_names)}"
}
