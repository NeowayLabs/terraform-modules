
module "public" {
    source               = "../../modules/public-network"
    resource_group_name  = "test-public-rg"
    location             = "eastus"
    vnet_name            = "test-vnet"
    vnet_address_space   = "10.31.0.0/16"
    subnet_prefix        = "10.31.1.0/24"
    subnet_name          = "test-public-subnet"
    security_group_name  = "test-public-nsg"
    route_table_name     = "test-public-rt"
    security_group_rules = "${local.nsg_rules}"
    route_table_routes   = "${local.rt_routes}"
}

locals {
    nsg_rules                     = [
      {
        name                       = "allow-inbound-subnets-to-internet"
        priority                   = "4000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "*"
        source_port_range          = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_port_range     = "80"
        destination_address_prefix = "Internet"
        description                = "Allow inbound packets from subnets access to internet"
      }
    ]

    rt_routes                     = []
}

