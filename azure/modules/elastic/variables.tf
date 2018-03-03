# Elasticserach variable definition

variable "env" {
  description = "Environment to orchestrate. This name will be use with a prefix for name of resource group, subnet, nsg, route table, instances"
  default = "test"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
  default = "eastus2"
}

variable "name" {
  description = "This name will be use with a prefix for name of resource group, subnet, nsg, route table, instances"
}

variable "vnet_name" {
  description = "Name of the vnet to associate."
}

variable "vnet_resource_group" {
  description = "Resource group name that the virtual network was provisioned in."
}

variable "subnet_address_prefix" {
  description = "The address prefix to use for the subnet."
}

variable "security_group_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, source_address_prefix, destination_port_range, destination_address_prefix, description]"
  type = "list"
  default = []
}

variable "route_table_routes" {
  description = "Routes for the route table using this format name = [name, address_prefix, next_hop_type, next_hop_in_ip_address]"
  type = "list"
  default = []
}

variable "elastic_username" {
  description = "The elastic username of the VM that will be deployed"
  default     = "bootstrap"
}

variable "elastic_public_ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
  default     = "~/.ssh/id_rsa.pub"
}

variable "master_nb_instances" {
  description = "Specify the number of instances of master node."
  default     = "3"
}

variable "master_vm_size" {
  description = "Specifies the size of the virtual machine for master node."
  default     = "Standard_DS2_v2"
}

variable "master_private_ip_address" {
  description = "A list of static IP address for each master node."
  default = [""]
}

variable "client_nb_instances" {
  description = "Specify the number of instances of client node."
  default     = "2"
}

variable "client_vm_size" {
  description = "Specifies the size of the virtual machine for client node."
  default     = "Standard_DS13_v2"
}

variable "client_private_ip_address" {
  description = "A list of static IP address for each client node."
  default = [""]
}

variable "data_vm_size" {
  description = "Specifies the size of the virtual machine for data node."
  default     = "Standard_L8s"
}

variable "rack_1_data_nb_instances" {
  description = "Specify the number of instances of data node in rack 1."
}

variable "rack_1_data_avset_update_domain_count" {
  description = "Specifies the number of update domains that are used for rack 1."
  default = "10"
}

variable "rack_1_data_avset_fault_domain_count" {
  description = "Specifies the number of fault domains that are used for rack 1."
  default = "2"
}

variable "rack_2_data_nb_instances" {
  description = "Specify the number of instances of data node in rack 2."
  default = "0"
}

variable "rack_2_data_avset_update_domain_count" {
  description = "Specifies the number of update domains that are used for rack 2."
  default = "10"
}

variable "rack_2_data_avset_fault_domain_count" {
  description = "Specifies the number of fault domains that are used for rack 2."
  default = "2"
}

variable "rack_3_data_nb_instances" {
  description = "Specify the number of instances of data node in rack 3."
  default = "0"
}

variable "rack_3_data_avset_update_domain_count" {
  description = "Specifies the number of update domains that are used for rack 3."
  default = "10"
}

variable "rack_3_data_avset_fault_domain_count" {
  description = "Specifies the number of fault domains that are used for rack 3."
  default = "2"
}

variable "rack_4_data_nb_instances" {
  description = "Specify the number of instances of data node in rack 4."
  default = "0"
}

variable "rack_4_data_avset_update_domain_count" {
  description = "Specifies the number of update domains that are used for rack 4."
  default = "10"
}

variable "rack_4_data_avset_fault_domain_count" {
  description = "Specifies the number of fault domains that are used for rack 4."
  default = "2"
}

