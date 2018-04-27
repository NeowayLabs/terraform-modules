# terraform-modules-network-security-group #

Create a network security group
-------------------------------

This Terraform module deploys a Network Security Group (NSG) in Azure and optionally attach it to the specified vnets.

This module is a complement to the Network module. Use the network_security_group_id from the output of this module to apply it to a subnet in the Azure Network module.

Usage with the generic module:
------------------------------

The following example demonstrate how to use the network-security-group module with a rule.

```hcl
module "network-security-group" {
    source                     = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/nsg"
    vnet_resource_group_name   = "nsg-resource-group"
    location                   = "eastus"
    security_group_name        = "nsg"
    rules                      = [
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
    tags                       = {
                                   environment = "dev"
                                   costcenter  = "it"
                                 }
}
```

Required Inputs
----
These variables must be set in the module block when using this module.

#### location
Description: The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions
 - default: "eastus2"

#### vnet_resource_group
Description: Resource group name that the virtual network was provisioned in.

#### security_group_name
Description: Network security group name

#### tags
Description: The tags to associate with your network security group.
 - type: "map"
 - default: {}

#### rules
Description: Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]
 - type: "list"
 - default: []

Optional Inputs
----

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

Outputs
----

#### network_security_group_id
Description: The id of network security grou created

#### network_security_group_name
Description: The name of network security grou created

## Authors

Originally created by [Damien Caro](https://github.com/dcaro) and [Richard Guthrie](https://github.com/rguthriemsft).

Changed by [Luciano Faustino](https:github.com/lborguetti) and [Paulo Pizarro](https://github.com/ppizarro).
