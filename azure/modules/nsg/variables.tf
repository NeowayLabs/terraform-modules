# Network Security Group definition
variable "resource_group_name" {
  default     = "nsg_rg"
  description = "Name of the resource group"
}

variable "location" {}

variable "security_group_name" {
  description = "Network security group name"
  default     = "nsg"
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

