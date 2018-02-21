
module "vnet" {
    source              = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/vnet?ref=azure-vnet"
    resource_group_name = "test-myapp"
    location            = "eastus"
    address_space       = "10.31.0.0/16"
    subnet_prefixes     = ["10.31.1.0/24", "10.31.2.0/24"]
    subnet_names        = ["test-subnet1", "test-subnet2"]

    tags                = {
                            environment = "dev"
                            costcenter  = "blackops"
                          }
}

