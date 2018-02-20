variable "nsg_name" {
  description = "Name of the nsg to create"
  default     = "acctnsg"
}

variable "resource_group_name" {
  description = "Default resource group name that the nsg will be created in."
  default     = "myapp-rg"
}

variable "location" {
  description = "The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  default     = "eastus2"
}

