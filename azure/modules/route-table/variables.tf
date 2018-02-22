# Route Table definition

variable "resource_group_name" {
  default     = "rt_rg"
  description = "Name of the resource group"
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "eastus2"
}

variable "route_table_name" {
  description = "Route Table name"
  default     = "rt"
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

