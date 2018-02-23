
resource "azurerm_resource_group" "public" {
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

module "vnet" {
    source              = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/vnet"
    resource_group_name = "${azurerm_resource_group.public.name}"
    location            = "${azurerm_resource_group.public.location}"
    vnet_name           = "${var.vnet_name}"
    address_space       = "${var.vnet_address_space}"
}

module "subnet" {
    source               = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/subnet"
    resource_group_name  = "${azurerm_resource_group.public.name}"
    location             = "${azurerm_resource_group.public.location}"
    vnet_name            = "${module.vnet.vnet_name}"
    subnet_name          = "${var.subnet_name}"
    subnet_prefix        = "${var.subnet_prefix}"
    security_group_name  = "${var.security_group_name}"
    security_group_rules = "${var.security_group_rules}"
    route_table_name     = "${var.route_table_name}"
    route_table_routes   = "${var.route_table_routes}"
}

