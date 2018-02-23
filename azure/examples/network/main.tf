
module "network" {
    source              = "../../modules/network"
    resource_group_name = "test-rg"
    location            = "eastus"
    vnet_name           = "test-vnet"
    address_space       = ["10.31.0.0/16"]
    subnet_prefixes     = ["10.31.1.0/24", "10.31.2.0/24"]
    subnet_names        = ["test-subnet1", "test-subnet2"]
    nsg_names           = ["test-nsg1", "test-nsg2"]
    route_table_names   = ["test-rt1", "test-rt2"]
    nsg_rules           = {
                            test-nsg1 = "$local.nsg1_rules"
                            test-nsg2 = "$local.nsg2_rules"
                          }
    route_table_routes  = {
                            test-rt1 = "$local.rt1_routes"
                            test-rt2 = "$local.rt2_routes"
                          }
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

    nsg2_rules                     = [
      {
        name                       = "myssh"
        priority                   = "300"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = "*"
        destination_port_range     = "22"
        destination_address_prefix = "10.31.2.0/24"
        description                = "description-myssh"
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

    rt2_routes                     = [
      {
        name                       = "default2"
        address_prefix             = "0.0.0.0/0"
        next_hop_type              = "VirtualAppliance"
        next_hop_in_ip_address     = "10.31.2.100"
      }
    ]
}

