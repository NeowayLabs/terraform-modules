# terraform-modules-route-table #

Create a route table
--------------------

This Terraform module deploys a Route Table in Azure.

This module is a complement to the Network module. Use the route_table_id from the output of this module to apply it to a subnet in the Azure Network module.

Usage with the generic module:
------------------------------

The following example demonstrate how to use the route-table module with a route.

```hcl
module "route-table" {
    source                     = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/route-table"
    vnet_resource_group_name   = "test-resource-group"
    location                   = "eastus"
    route_table_name           = "rt1"
    routes                     = [
      {
        name                       = "acceptanceTestRoute1"
        address_prefix             = "10.1.0.0/16"
        next_hop_type              = "vnetlocal"
      }
    ]
    tags                       = {
                                   environment = "dev"
                                   costcenter  = "it"
                                 }
}
```

Required Inputs
----
These variables must be set in the module block when using this module.

#### vnet_resource_group
Description: Resource group name that the virtual network was provisioned in.

#### route_table_name
Description: Route Table name

Optional Inputs
----

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

#### location
Description: The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions
 - default: "eastus2"

#### tags
Description: The tags to associate with your route table.
 - type: "map"
 - default: {}

#### routes
Description: Routes for the route table using this format name = [name, address_prefix, next_hop_type, next_hop_in_ip_address]
 - type: "list"
 - default: []

Outputs
----

#### route_table_id
Description: The id of route table created

#### route_table_name
Description: The name of route table created

## Authors

Originally created by [Luciano Faustino](https:github.com/lborguetti) and [Paulo Pizarro](https://github.com/ppizarro).
