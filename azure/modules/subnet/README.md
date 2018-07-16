# terraform-modules-subnet #

Create a basic subnet network in Azure
==============================================================================

This Terraform module deploys a subnet in Azure and associate it for a vnet.

The module can create too a security group and/or a route table associated to this subnet.

Usage
-----

```hcl
module "subnet" {
    source                = "git::ssh://git@github.com/NeowayLabs/terraform-modules.git//azure/modules/subnet"
    location              = "eastus"
    vnet_name             = "test-vnet"
    vnet_resource_group   = "test-resource-group"
    subnet_name           = "test-subnet1"
    subnet_address_prefix = "10.0.1.0/24"
    security_group_name   = "test-nsg1"
    security_group_rules  = "$local.nsg1_rules"
    route_table_name      = "test-rt1"
    route_table_routes    = "$local.rt1_routes"
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

Required Inputs
----
These variables must be set in the module block when using this module.

#### vnet_resource_group
Description: Default resource group name that the subnet will be created in.

#### vnet_name
Description: Name of the vnet to associate.

#### subnet_name
Description: The name of the subnet. Changing this forces a new resource to be created.

#### security_group_name
Description: The network security group name will be created and associated to the newly subnet.

#### route_table_name
Description: The route table name will be created and associated to the newly subnet.

Optional Inputs
----

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

#### location
Description: The location/region where the subnet will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions
 - default: "eastus2"

#### subnet_address_prefix
Description: The address prefix to use for the subnet.
 - default: "10.0.1.0/24"

#### security_group_rules
Description: Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]
 - type: "list"
 - default: []

#### route_table_routes
Description: Routes for the route table using this format name = [name, address_prefix, next_hop_type, next_hop_in_ip_address]
 - type: "list"
 - default: []

Outputs
----

#### subnet_id
Description: The id of subnet created inside the vnet

#### subnet_name
Description: The Name of the newly created subnet

#### subnet_address_prefix
Description: The address prefix for the newly created subnet

#### subnet_nsg_id
Description: The id of NSG created and associated to the newly subnet

#### subnet_route_table_id
Description: The id of route table created and associated to the newly subnet

