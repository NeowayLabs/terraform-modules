
resource "azurerm_resource_group" "public" {
  name     = "${var.env}-network"
  location = "${var.location}"
}

module "vnet" {
    source              = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/vnet?ref=public-network"
    resource_group_name = "${azurerm_resource_group.public.name}"
    location            = "${azurerm_resource_group.public.location}"
    vnet_name           = "${var.env}-vnet"
    address_space       = "${var.vnet_address_space}"
}

module "subnet" {
    source               = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/subnet"
    resource_group_name  = "${azurerm_resource_group.public.name}"
    location             = "${azurerm_resource_group.public.location}"
    vnet_name            = "${module.vnet.vnet_name}"
    subnet_name          = "${var.env}-public-subnet"
    subnet_prefix        = "${var.subnet_prefix}"
    security_group_name  = "${var.env}-public-security-group"
    security_group_rules = "${var.security_group_rules}"
    route_table_name     = "${var.env}-public-route-table"
    route_table_routes   = "${var.route_table_routes}"
}

