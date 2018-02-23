# Network definition

variable "resource_group_name" {
  description = "Default resource group name that the network will be created in."
  default = "myapp-rg"
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default = "eastus2"
}

variable "vnet_name" {
  description = "Name of the vnet to create"
  default = "acctvnet"
}

variable "address_space" {
  description = "A list of address space that will be used by the virtual network."
  type = "list"
  default = ["10.0.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default = ["10.0.1.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default = ["subnet1"]
}

variable "nsg_names" {
  description = "A list of network security group names for each subnet inside the vNet."
  default = ["nsg1"]
}

variable "route_table_names" {
  description = "A list of route table names for each subnet inside the vNet."
  default = ["rt1"]
}

variable "nsg_rules" {
  description = "A map of network security group rules. The keys are the NSG name and the values are the rules for the respective NSG."
  default = {}
}

variable "route_table_routes" {
  description = "A map of route table routes. The keys are the route table name and the values are the routes for the respective route table."
  default = {}
}

# Security Rules definition

# Security rules
# [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
# All the fields are required.
variable "rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
  type = "list"
  default = []
}

# Routes definition

# Routes arguments
# [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
# All the fields are required excepted next_hop_in_ip_address.
variable "routes" {
  description = "Routes for the route table using this format name = [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
  type = "list"
  default = []
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type = "map"
  default = {}
}
