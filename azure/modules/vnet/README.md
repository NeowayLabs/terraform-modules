# terraform-modules-vnet #

Create a basic virtual network in Azure
==============================================================================

This Terraform module deploys a Virtual Network in Azure with a subnet or a set of subnets passed in as input parameters.

The module does not create nor expose a security group. This would need to be defined separately as additional security rules on subnets in the deployed network.

Usage
-----

```hcl
module "vnet" {
    source                  = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/vnet"
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

Authors
=======
Originally created by [Eugene Chuvyrov](http://github.com/echuvyrov)
