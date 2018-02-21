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
    source                     = "git::https://gitlab.neoway.com.br/labs/terraform-modules/azure/modules/nsg"
    resource_group_name        = "nsg-resource-group"
    location                   = "westus"
    security_group_name        = "nsg"
    rules                      = [
      {
        name                       = "myhttp"
        priority                   = "200"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = ["*"]
        destination_port_range     = "80"
        destination_address_prefix = ["10.0.0.0/24"]
        description                = "description-myhttp"
      }
    ]
    tags                       = {
                                   environment = "dev"
                                   costcenter  = "it"
                                 }
}
```

## Authors

Originally created by [Damien Caro](https://github.com/dcaro) and [Richard Guthrie](https://github.com/rguthriemsft).

Changed by [Luciano Faustino](https:github.com/lborguetti) and [Paulo Pizarro](https://github.com/ppizarro).
