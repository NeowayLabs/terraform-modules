
module "vnet" {
    source              = "../../modules/vnet"
    resource_group_name = "test-network-rg"
    location            = "eastus"
    vnet_name           = "test-vnet"
    address_space       = ["10.31.0.0/16"]
}

module "elastic" {
    source               = "../../modules/elastic"
    location             = "eastus"
    env                  = "test"
    name                 = "es5"
    vnet_name            = "test-vnet"
    subnet_prefix        = "10.31.10.0/24"
    security_group_rules = "${local.nsg_rules}"
    route_table_routes   = "${local.rt_routes}"

    master_nb_instances       = "3"
    master_private_ip_address = ["10.31.10.10","10.31.10.11","10.31.10.12"]

    client_nb_instances       = "2"
    client_private_ip_address = ["10.31.10.20","10.31.10.21"]

    rack_1_data_nb_instances              = "10"
    rack_1_data_avset_update_domain_count = "10"
    rack_1_data_avset_fault_domain_count  = "2"

    elastic_username       = "bootstrap"
    elastic_public_ssh_key = "~/.ssh/id_rsa.pub"
}

locals {
    nsg_rules                     = [
      {
        name                       = "allow-inbound-subnets-to-elastic"
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_port_range     = "9200"
        destination_address_prefix = "10.31.10.0/24"
        description                = "Allow inbound packets from vnet to access elastic"
      }
    ]

    rt_routes                     = []
}

