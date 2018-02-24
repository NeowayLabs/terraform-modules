
module "vnet" {
    source              = "../../modules/vnet"
    resource_group_name = "test-network-rg"
    location            = "eastus"
    vnet_name           = "test-vnet"
    address_space       = ["10.31.0.0/16"]
}

module "subnet" {
    source               = "../../modules/subnet"
    resource_group_name  = "test-network-rg"
    location             = "eastus"
    vnet_name            = "test-vnet"
    subnet_prefix        = "10.31.1.0/24"
    subnet_name          = "test-subnet1"
    security_group_name  = "test-nsg1"
    route_table_name     = "test-rt1"
    security_group_rules = "${local.nsg1_rules}"
}

module "vm" {
    source               = "../../modules/linux-vm"
    resource_group_name  = "test-service-rg"
    location             = "eastus"
    subnet_id            = "${module.subnet.subnet_id}"
    vm_hostname          = "test-service"
    nb_instances         = 2
}

locals {
    nsg1_rules                     = [
      {
        name                       = "allow-inbound-ssh"
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "22"
        destination_address_prefix = "10.31.1.0/24"
        description                = "allow inbound ssh packets"
      }
    ]
}

