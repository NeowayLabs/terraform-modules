# terraform-modules-subnet #

Create a basic subnet network in Azure
==============================================================================

This Terraform module deploys a subnet in Azure and associate it for a vnet.

The module can create too a security group and/or a route table associated to this subnet.

Usage
-----

```hcl
module "subnet" {
    source               = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/subnet"
    resource_group_name  = "test-resource-group"
    location             = "eastus"
    vnet_name            = "test-vnet"
    subnet_name          = "test-subnet1"
    subnet_prefix        = "10.0.1.0/24"
    security_group_name  = "test-nsg1"
    security_group_rules = "$local.nsg1_rules"
    route_table_name     = "test-rt1"
    route_table_routes   = "$local.rt1_routes"
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
        destination_address_prefix = "10.0.0.0/24"
        description                = "description-myhttp"
      }
    ]

    rt1_routes                     = [
      {
        name                       = "acceptanceTestRoute1"
        address_prefix             = "10.1.0.0/16"
        next_hop_type              = "vnetlocal"
      }
    ]
}
```

