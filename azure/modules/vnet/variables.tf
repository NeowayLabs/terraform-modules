# Virtual Network definition

variable "vnet_name" {
  description = "Name of the vnet to create"
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default = "eastus2"
}

variable "address_space" {
  description = "A list of address space that will be used by the virtual network."
  type = "list"
  default = ["10.0.0.0/16"]
}

variable "dns_servers" {
  description = "The DNS servers to be used with vnet. If no values specified, this defaults to Azure DNS"
  default = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default = []
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default = []
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type = "map"
  default = {}
}

variable "route_table_ids" {
  description = "A map of subnet name to 'Route Table IDs"
  type = "map"
  default = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type = "map"
  default = {}
}
