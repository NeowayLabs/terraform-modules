module "public" {
  source                = "../../modules/public-network"
  env                   = "test"
  location              = "eastus"
  vnet_address_space    = ["10.31.0.0/16"]
  subnet_address_prefix = "10.31.1.0/24"
  security_group_rules  = "${local.nsg_rules}"
  route_table_routes    = "${local.rt_routes}"

  bastion_private_ip_address = "10.31.1.150"
  bastion_admin_username     = "bootstrap"
  bastion_public_ssh_key     = "~/.ssh/id_rsa.pub"
}

locals {
  nsg_rules = [
    {
      name                       = "allow-inbound-subnets-to-internet"
      priority                   = "4000"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "*"
      source_port_range          = "*"
      source_address_prefix      = "VirtualNetwork"
      destination_port_range     = "80"
      destination_address_prefix = "Internet"
      description                = "Allow inbound packets from subnets access to internet"
    },
  ]

  rt_routes = []
}
