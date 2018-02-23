# Subnet definition

variable "resource_group_name" {
  description = "Default resource group name that the public network will be created in."
  default     = "test-public-rg"
}

variable "location" {
  description = "The location/region where the subnet will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "eastus2"
}

variable "vnet_name" {
  description = "Name of the vnet to associate."
  default     = "test-vnet"
}

variable "vnet_address_space" {
  description = "A list of address space that will be used by the virtual network."
  default     = "[10.0.0.0/16]"
}

variable "subnet_name" {
  description = "The name of the public subnet. Changing this forces a new resource to be created."
  default     = "test-public-subnet"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the public subnet."
  default     = "10.0.1.0/24"
}

variable "security_group_name" {
  description = "The network security group name will be created and associated to the public subnet."
  default     = "test-public-nsg"
}

variable "route_table_name" {
  description = "The route table name will be created and associated to the public subnet."
  default     = "test-public-rt"
}

# Security group rules arguments
# [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
# All the fields are required.
variable "security_group_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
  type        = "list"
  default     = []
}

# Route table routes arguments
# [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
# All the fields are required excepted next_hop_in_ip_address.
variable "route_table_routes" {
  description = "Routes for the route table using this format name = [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
  type        = "list"
  default     = []
}

