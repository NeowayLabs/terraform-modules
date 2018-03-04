# Network Security Group definition

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "eastus2"
}

variable "vnet_resource_group" {
  description = "Resource group name that the virtual network was provisioned in."
}

variable "security_group_name" {
  description = "Network security group name"
}

variable "tags" {
  description = "The tags to associate with your network security group."
  type        = "map"
  default     = {}
}

# Security Rules definition

# Security rules
# [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
# All the fields are required.
variable "rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
  type        = "list"
  default     = []
}

