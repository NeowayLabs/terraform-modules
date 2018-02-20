# terraform-modules-azure-nsg #

Create a basic network security group in Azure
==============================================================================

This Terraform module deploys a Network Security Group in Azure with just one rule denying all inbound trafic.

Usage
-----

```hcl
module "nsg" {
    source              = "git::https://gitlab.neoway.com.br/labs/terraform-modules/tree/azure-vnet/azure/modules/nsg"
    resource_group_name = "myapp"
    location            = "eastus2"
}
```

