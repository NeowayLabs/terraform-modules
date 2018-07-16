# terraform-modules-vnet #

Create a basic virtual network in Azure
==============================================================================

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.

The module does not create nor expose a security group. This would need to be defined separately as additional security rules on subnets in the deployed network.

Usage
-----

```hcl
module "vnet" {
    source                  = "git::ssh://git@github.com/NeowayLabs/terraform-modules.git//azure/modules/vnet"
    resource_group_name     = "test-resource-group"
    location                = "eastus"
    vnet_name               = "test-vnet"
    address_space           = ["10.0.0.0/16"]
    subnet_address_prefixes = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    subnet_names            = ["subnet1", "subnet2", "subnet3"]
    tags                    = {
                                environment = "dev"
                                costcenter  = "it"
                              }
}
```

Required Inputs
----
These variables must be set in the module block when using this module.

#### vnet_name
Description: Name of the vnet to create

#### resource_group_name
Description: Default resource group name that the network will be created in.

Optional Inputs
----

#### location
Description: The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions
 - default: "eastus2"

#### address_space
Description: A list of address space that will be used by the virtual network.
 - type: "list"
 - default: ["10.0.0.0/16"]

#### dns_servers
Description: The DNS servers to be used with vnet. If no values specified, this defaults to Azure DNS
 - default: []

#### subnet_address_prefixes
Description: The address prefix to use for the subnet.
 - default: []

#### subnet_names
Description: A list of public subnets inside the vNet.
 - default: []

#### nsg_ids
Description: A map of subnet name to Network Security Group IDs
 - type: "map"
 - default: {}

#### route_table_ids
Description: A map of subnet name to 'Route Table IDs
 - type: "map"
 - default: {}

#### tags
Description: The tags to associate with your network and subnets.
 - type: "map"
 - default: {}

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

#### admin_username
Description: The admin username of the VM that will be deployed
 - default: "bootstrap"

Outputs
----

#### vnet_id
Description: The id of the newly created vNet

#### vnet_location
Description: The location of the newly created vNet

#### vnet_resource_group
Description: The resource group of the newly created vNet

#### vnet_name
Description: The Name of the newly created vNet

#### vnet_address_space
Description: The address space of the newly created vNet

#### vnet_subnets
Description: The ids of subnets created inside the newl vNet

Authors
=======
Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)
