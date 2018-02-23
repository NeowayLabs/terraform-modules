
module "vnet" {
    source              = "../../modules/vnet"
    resource_group_name = "test-rg"
    location            = "eastus"
    vnet_name           = "test-vnet"
    address_space       = ["10.31.0.0/16"]
    tags                = {
                            environment = "dev"
                            costcenter  = "blackops"
                          }
}

module "subnet" {
    source               = "../../modules/subnet"
    resource_group_name  = "test-rg"
    location             = "eastus"
    vnet_name            = "test-vnet"
    subnet_prefix        = "10.31.1.0/24"
    subnet_name          = "test-subnet1"
    security_group_name  = "test-nsg1"
    route_table_name     = "test-rt1"
    security_group_rules = "${local.nsg1_rules}"
    route_table_routes   = "${local.rt1_routes}"
}

locals {
    nsg1_rules                     = [
      {
        name                       = "myhttp"
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "80"
        destination_address_prefix = "10.31.1.0/24"
        description                = "description-myhttp"
      }
    ]

    rt1_routes                     = [
      {
        name                       = "default1"
        address_prefix             = "0.0.0.0/0"
        next_hop_type              = "VirtualAppliance"
        next_hop_in_ip_address     = "10.31.1.100"
      }
    ]
}

