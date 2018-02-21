# terraform-modules-network-security-group #

Create a network security group
-------------------------------

This Terraform module deploys a Network Security Group (NSG) in Azure and optionally attach it to the specified vnets.

This module is a complement to the Network module. Use the network_security_group_id from the output of this module to apply it to a subnet in the Azure Network module.

This module includes a a set of pre-defined rules for commonly used protocols (for example HTTP or SSH).

Usage with the generic module:
------------------------------

The following example demonstrate how to use the network-security-group module with a combination of predefined and custom rules.

```hcl
module "network-security-group" {
    source                     = "git::https://gitlab.neoway.com.br/labs/terraform-modules/azure/modules/nsg"
    resource_group_name        = "nsg-resource-group"
    location                   = "westus"
    security_group_name        = "nsg"
    predefined_rules           = [
      {
        name                   = "SSH"
        priority               = "500"
        source_address_prefix  = ["10.0.3.0/24"]
      },
      {
        name                   = "LDAP"
        source_port_range      = "1024-1026"
      }
    ]
    custom_rules               = [
      {
        name                   = "myhttp"
        priority               = "200"
        direction              = "Inbound"
        access                 = "Allow"
        protocol               = "tcp"
        destination_port_range = "8080"
        description            = "description-myhttp"
      }
    ]
    tags                       = {
                                   environment = "dev"
                                   costcenter  = "it"
                                 }
}
```
## Authors

Originally created by [Damien Caro](http://github.com/dcaro) and [Richard Guthrie](https://github.com/rguthriemsft).

