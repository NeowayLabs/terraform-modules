# terraform-modules-elastic #

Create a Elastic Search cluster in Azure
==============================================================================

This Terraform module create a elastic search cluster in Azure following Neoway rules.

The resources below will be created:

 * elastic subnet
 * elastic NSG
 * elastic route table
 * available set for master nodes
 * master nodes
 * available set for client nodes
 * client nodes
 * available set for data nodes in rack 1
 * data nodes in rack 1
 * available set for data nodes in rack 2 (optional)
 * data nodes in rack 2 (optional)

Usage
-----

```hcl
module "elastic" {
    source               = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/elastic"
    location             = "eastus"
    env                  = "qa"
    name                 = "es5"
    vnet_name            = "qa-vnet"
    subnet_prefix        = "10.0.10.0/24"
    security_group_rules = "${local.nsg_rules}"
    route_table_routes   = "${local.rt_routes}"

    master_nb_instances       = "3"
    master_private_ip_address = ["10.0.10.10","10.0.10.11","10.0.10.12"]

    client_nb_instances       = "2"
    client_private_ip_address = ["10.0.10.20","10.0.10.21"]

    rack_1_data_nb_instances              = "10"
    rack_1_data_avset_update_domain_count = "10"
    rack_1_data_avset_fault_domain_count  = "2"

    elastic_username       = "bootstrap"
    elastic_public_ssh_key = "~/.ssh/id_rsa.pub"
}

locals {
    nsg_rules                     = [
      {
        name                       = "allow-inbound-subnets-to-elastic"
        priority                   = "1000"
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "tcp"
        source_port_range          = "*"
        source_address_prefix      = "VirtualNetwork"
        destination_port_range     = "9200"
        destination_address_prefix = "10.0.10.0/24"
        description                = "Allow inbound packets from vnet to access elastic"
      }
    ]

    rt_routes                     = []
}
```

