
provider "azurerm" {
  version = "~> 1.1"
}

resource "azurerm_resource_group" "public" {
  name     = "${var.env}-network"
  location = "${var.location}"
}

module "vnet" {
    source              = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/vnet"
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

module "bastion" {
    source                        = "../../modules/linux-vm"
    resource_group_name           = "${azurerm_resource_group.public.name}"
    location                      = "${azurerm_resource_group.public.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-bastion"
    vm_os_simple                  = "${var.bastion_os_simple}"
    vm_size                       = "${var.bastion_virtual_machine_instance_size}"
    avset_update_domain_count     = "${var.bastion_avset_update_domain_count}"
    avset_fault_domain_count      = "${var.bastion_avset_fault_domain_count}"
    enable_ip_forwarding          = "true"
    private_ip_address_allocation = "static"
    private_ip_address_list       = ["${var.bastion_private_ip_address}"]
    admin_username                = "${var.bastion_admin_username}"
    ssh_key                       = "${var.bastion_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "bastion"
                                    }
}

