
module "vnet" {
    source              = "../../modules/vnet"
    resource_group_name = "test-rg"
    location            = "eastus"
    vnet_name           = "test-vnet"
    address_space       = ["10.31.0.0/16"]
    subnet_prefixes     = ["10.31.1.0/24", "10.31.2.0/24"]
    subnet_names        = ["test-subnet1", "test-subnet2"]

    tags                = {
                            environment = "dev"
                            costcenter  = "blackops"
                          }
}

