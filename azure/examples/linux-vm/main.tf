resource "azurerm_resource_group" "vm" {
  name     = "test-vm-rg"
  location = "eastus"
}

module "vnet" {
  source              = "../../modules/vnet"
  resource_group_name = "test-vm-rg"
  location            = "eastus"
  vnet_name           = "test-vnet"
  address_space       = ["10.31.0.0/16"]
}

module "subnet" {
  source                = "../../modules/subnet"
  vnet_resource_group   = "test-vm-rg"
  location              = "eastus"
  vnet_name             = "test-vnet"
  subnet_address_prefix = "10.31.1.0/24"
  subnet_name           = "test-subnet1"
  security_group_name   = "test-nsg1"
  route_table_name      = "test-rt1"
  security_group_rules  = "${local.nsg1_rules}"
}

module "vm-private" {
  nb_instances        = 2
  source              = "../../modules/linux-vm"
  resource_group_name = "test-vm-rg"
  location            = "eastus"
  subnet_id           = "${module.subnet.subnet_id}"
  vm_hostname         = "test-private"

  data_disk              = "true"
  data_disk_size_gb      = "64"
  data_managed_disk_type = "Premium_LRS"
}

module "vm-public" {
  nb_instances        = 2
  source              = "../../modules/linux-vm"
  resource_group_name = "${module.vnet.vnet_resource_group}"
  location            = "eastus"
  subnet_id           = "${module.subnet.subnet_id}"
  vm_hostname         = "test-public"
  enable_public_ip    = "true"
  public_ip_dns_list  = ["test0-public", "test1-public"]
}

locals {
  nsg1_rules = [
    {
      name                       = "allow-inbound-ssh"
      priority                   = "200"
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "tcp"
      source_port_range          = "*"
      source_address_prefix      = "*"
      destination_port_range     = "22"
      destination_address_prefix = "10.31.1.0/24"
      description                = "allow inbound ssh packets"
    },
  ]
}
