# terraform-modules-network #

> __note: This module doesn't work with last terraform version. Waiting support "count" parameter for modules.__
> [Support the count parameter for modules](https://github.com/hashicorp/terraform/issues/953)

Create a basic network in Azure
==============================================================================

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.

The module can create security group and route tables and to associate them for your respective subnet in the deployed network.

Usage
-----

```hcl

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
        destination_address_prefix = "10.0.0.0/24"
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
        destination_address_prefix = "10.31.0.0/24"
        description                = "description-myssh"
      }
    ]

    rt1_routes                     = [
      {
        name                       = "acceptanceTestRoute1"
        address_prefix             = "10.1.0.0/16"
        next_hop_type              = "vnetlocal"
      }
    ]

    rt2_routes                     = [
      {
        name                       = "acceptanceTestRoute2"
        address_prefix             = "10.2.0.0/16"
        next_hop_type              = "vnetlocal"
      }
    ]
}

module "network" {
    source              = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/network"
    resource_group_name = "test-resource-group"
    location            = "eastus"
    vnet_name           = "test-vnet"
    address_space       = "10.0.0.0/16"
    subnet_prefixes     = ["10.0.1.0/24", "10.0.2.0/24"]
    subnet_names        = ["subnet1", "subnet2"]
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
```

