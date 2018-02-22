# Virtual Network definition

variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = "acctvnet"
}

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  default     = "myapp-rg"
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "eastus2"
}

variable "address_space" {
  description = "The address space that is used by the virtual network."
  default     = "10.0.0.0/16"
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1"]
}

variable "nsg_ids" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = "map"

  default = {}
}

variable "route_table_ids" {
  description = "A map of subnet name to 'Route Table IDs"
  type        = "map"

  default = {}
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = "map"

  default = {}
}
