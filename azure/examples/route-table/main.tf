resource "azurerm_resource_group" "vm" {
  name     = "test-route-rg"
  location = "eastus"
}

module "vnet" {
  source                  = "../../modules/vnet"
  resource_group_name     = "test-route-rg"
  location                = "eastus"
  vnet_name               = "test-vnet"
  address_space           = ["10.31.0.0/16"]
  subnet_address_prefixes = ["10.31.1.0/24", "10.31.2.0/24"]
  subnet_names            = ["test-subnet1", "test-subnet2"]

  route_table_ids = {
    test-subnet1 = "${module.rt1.route_table_id}"
    test-subnet2 = "${module.rt2.route_table_id}"
  }
}

module "rt1" {
  source              = "../../modules/route-table"
  vnet_resource_group = "test-route-rg"
  location            = "eastus"
  route_table_name    = "test-rt-1"

  routes = [
    {
      name                   = "default1"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.31.1.100"
    },
  ]
}

module "rt2" {
  source              = "../../modules/route-table"
  vnet_resource_group = "test-route-rg"
  location            = "eastus"
  route_table_name    = "test-rt-2"

  routes = [
    {
      name                   = "default2"
      address_prefix         = "0.0.0.0/0"
      next_hop_type          = "VirtualAppliance"
      next_hop_in_ip_address = "10.31.2.100"
    },
  ]
}
