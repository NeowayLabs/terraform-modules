# Route Table definition

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "eastus2"
}

variable "vnet_resource_group" {
  description = "Resource group name that the virtual network was provisioned in."
}

variable "route_table_name" {
  description = "Route Table name"
}

variable "tags" {
  description = "The tags to associate with your route table."
  type        = "map"
  default     = {}
}

# Routes definition

# Routes arguments
# [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
# All the fields are required excepted next_hop_in_ip_address.
variable "routes" {
  description = "Routes for the route table using this format name = [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
  type        = "list"
  default     = []
}
