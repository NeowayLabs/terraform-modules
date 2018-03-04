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

## Authors

Originally created by [Luciano Faustino](https:github.com/lborguetti) and [Paulo Pizarro](https://github.com/ppizarro).
