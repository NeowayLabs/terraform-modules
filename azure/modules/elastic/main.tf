
provider "azurerm" {
  version = "~> 1.1"
}

resource "azurerm_resource_group" "elastic" {
  name     = "${var.env}-${var.name}"
  location = "${var.location}"
}

module "subnet" {
    source                = "../subnet"
    location              = "${var.location}"
    vnet_name             = "${var.vnet_name}"
    vnet_resource_group   = "${var.vnet_resource_group}"
    subnet_name           = "${var.env}-${var.name}-subnet"
    subnet_address_prefix = "${var.subnet_address_prefix}"
    security_group_name   = "${var.env}-${var.name}-security-group"
    security_group_rules  = "${var.security_group_rules}"
    route_table_name      = "${var.env}-${var.name}-route-table"
    route_table_routes    = "${var.route_table_routes}"
}

module "master" {
    source                        = "../linux-vm"
    resource_group_name           = "${azurerm_resource_group.elastic.name}"
    location                      = "${azurerm_resource_group.elastic.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-${var.name}-master"
    nb_instances                  = "${var.master_nb_instances}"
    vm_os_simple                  = "UbuntuServer"
    vm_size                       = "${var.master_vm_size}"
    avset_update_domain_count     = "3"
    avset_fault_domain_count      = "3"
    private_ip_address_allocation = "static"
    private_ip_address_list       = "${var.master_private_ip_address}"
    admin_username                = "${var.elastic_username}"
    ssh_key                       = "${var.elastic_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "${var.name}-master"
                                    }
}

module "client" {
    source                        = "../linux-vm"
    resource_group_name           = "${azurerm_resource_group.elastic.name}"
    location                      = "${azurerm_resource_group.elastic.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-${var.name}-client"
    nb_instances                  = "${var.client_nb_instances}"
    vm_os_simple                  = "UbuntuServer"
    vm_size                       = "${var.client_vm_size}"
    avset_update_domain_count     = "5"
    avset_fault_domain_count      = "3"
    private_ip_address_allocation = "static"
    private_ip_address_list       = "${var.client_private_ip_address}"
    admin_username                = "${var.elastic_username}"
    ssh_key                       = "${var.elastic_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "${var.name}-client"
                                    }
}

module "rack_1_data" {
    source                        = "../linux-vm"
    resource_group_name           = "${azurerm_resource_group.elastic.name}"
    location                      = "${azurerm_resource_group.elastic.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-${var.name}-rack-1-data"
    nb_instances                  = "${var.rack_1_data_nb_instances}"
    vm_os_simple                  = "UbuntuServer"
    vm_size                       = "${var.data_vm_size}"
    avset_update_domain_count     = "${var.rack_1_data_avset_update_domain_count}"
    avset_fault_domain_count      = "${var.rack_1_data_avset_fault_domain_count}"
    private_ip_address_allocation = "dynamic"
    admin_username                = "${var.elastic_username}"
    ssh_key                       = "${var.elastic_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "${var.name}-rack-1-data"
                                    }
}

module "rack_2_data" {
    source                        = "../linux-vm"
    resource_group_name           = "${azurerm_resource_group.elastic.name}"
    location                      = "${azurerm_resource_group.elastic.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-${var.name}-rack-2-data"
    nb_instances                  = "${var.rack_2_data_nb_instances}"
    vm_os_simple                  = "UbuntuServer"
    vm_size                       = "${var.data_vm_size}"
    avset_update_domain_count     = "${var.rack_2_data_avset_update_domain_count}"
    avset_fault_domain_count      = "${var.rack_2_data_avset_fault_domain_count}"
    private_ip_address_allocation = "dynamic"
    admin_username                = "${var.elastic_username}"
    ssh_key                       = "${var.elastic_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "${var.name}-rack-2-data"
                                    }
}

module "rack_3_data" {
    source                        = "../linux-vm"
    resource_group_name           = "${azurerm_resource_group.elastic.name}"
    location                      = "${azurerm_resource_group.elastic.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-${var.name}-rack-3-data"
    nb_instances                  = "${var.rack_3_data_nb_instances}"
    vm_os_simple                  = "UbuntuServer"
    vm_size                       = "${var.data_vm_size}"
    avset_update_domain_count     = "${var.rack_3_data_avset_update_domain_count}"
    avset_fault_domain_count      = "${var.rack_3_data_avset_fault_domain_count}"
    private_ip_address_allocation = "dynamic"
    admin_username                = "${var.elastic_username}"
    ssh_key                       = "${var.elastic_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "${var.name}-rack-3-data"
                                    }
}

module "rack_4_data" {
    source                        = "../linux-vm"
    resource_group_name           = "${azurerm_resource_group.elastic.name}"
    location                      = "${azurerm_resource_group.elastic.location}"
    subnet_id                     = "${module.subnet.subnet_id}"
    vm_hostname                   = "${var.env}-${var.name}-rack-4-data"
    nb_instances                  = "${var.rack_4_data_nb_instances}"
    vm_os_simple                  = "UbuntuServer"
    vm_size                       = "${var.data_vm_size}"
    avset_update_domain_count     = "${var.rack_4_data_avset_update_domain_count}"
    avset_fault_domain_count      = "${var.rack_4_data_avset_fault_domain_count}"
    private_ip_address_allocation = "dynamic"
    admin_username                = "${var.elastic_username}"
    ssh_key                       = "${var.elastic_public_ssh_key}"
    tags                          = {
                                      env  = "${var.env}"
                                      role = "${var.name}-rack-4-data"
                                    }
}
