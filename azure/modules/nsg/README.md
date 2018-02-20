# terraform-modules-azure-nsg #

Create a basic network security group in Azure
==============================================================================

This Terraform module deploys a Network Security Group in Azure with just one rule denying all inbound trafic.

resource "azurerm_network_security_rule" "denyinboundall" {
  name                        = "deny-inbound-all"
  priority                    = 4000
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.nsg.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}

Usage
-----

```hcl
module "nsg" {
    source              = "git::https://gitlab.neoway.com.br/labs/terraform-modules/tree/azure-vnet/azure/modules/nsg"
    resource_group_name = "myapp"
    location            = "eastus2"
}
```

Example adding another network security rule:
-----------------------------------------------

```hcl
variable "resource_group_name" { }

module "nsg" {
    source              = "git::https://gitlab.neoway.com.br/labs/terraform-modules/tree/azure-vnet/azure/modules/nsg"
    resource_group_name = "myapp"
    location            = "eastus2"
}

resource "azurerm_network_security_rule" "allowsshinbound" {
  depends_on                  = ["module.nsg"]
  name                        = "allow-inbound-ssh"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = "${azurerm_resource_group.nsg.name}"
  network_security_group_name = "${azurerm_network_security_group.nsg.name}"
}
```

