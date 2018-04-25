resource "azurerm_resource_group" "vm" {
  name     = "test-nsg-rg"
  location = "eastus"
}

module "vnet" {
  source                  = "../../modules/vnet"
  resource_group_name     = "test-nsg-rg"
  location                = "eastus"
  vnet_name               = "test-vnet"
  address_space           = ["10.31.0.0/16"]
  subnet_address_prefixes = ["10.31.1.0/24", "10.31.2.0/24"]
  subnet_names            = ["test-subnet1", "test-subnet2"]

  nsg_ids = {
    test-subnet1 = "${module.nsg1.network_security_group_id}"
    test-subnet2 = "${module.nsg2.network_security_group_id}"
  }
}

module "nsg1" {
  source              = "../../modules/nsg"
  vnet_resource_group = "test-nsg-rg"
  location            = "eastus"
  security_group_name = "test-nsg-1"

  rules = [
    {
      name                       = "myhttp"
      priority                   = "200"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "tcp"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = "80"
      destination_address_prefix = "10.31.0.0/24"
      description                = "description-myhttp"
    },
  ]
}

module "nsg2" {
  source              = "../../modules/nsg"
  vnet_resource_group = "test-nsg-rg"
  location            = "eastus"
  security_group_name = "test-nsg-2"

  rules = [
    {
      name                       = "myssh"
      priority                   = "300"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "tcp"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = "22"
      destination_address_prefix = "10.31.0.0/24"
      description                = "description-myssh"
    },
  ]
}
