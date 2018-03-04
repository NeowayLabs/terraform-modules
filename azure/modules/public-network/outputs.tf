output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = "${module.vnet.vnet_id}"
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = "${module.vnet.vnet_name}"
}

output "vnet_resource_group" {
  description = "The resource group of the newly created vNet"
  value       = "${module.vnet.vnet_resource_group}"
}

output "vnet_address_space" {
  description = "A list of address space of the newly created vNet"
  value       = "${module.vnet.vnet_address_space}"
}

output "public_network_location" {
  description = "The location of the public network"
  value       = "${module.vnet.vnet_location}"
}

output "public_network_subnet_id" {
  description = "The id of public subnet"
  value       = "${module.subnet.subnet_id}"
}

output "public_network_subnet_name" {
  description = "The Name of the public subnet"
  value       = "${module.subnet.subnet_name}"
}

output "public_network_subnet_address_prefix" {
  description = "The address prefix for the public subnet"
  value       = "${module.subnet.subnet_address_prefix}"
}

output "public_network_nsg_id" {
  description = "The id of the public NSG"
  value       = "${module.subnet.subnet_nsg_id}"
}

output "public_network_route_table_id" {
  description = "The id of the public route table"
  value       = "${module.subnet.subnet_route_table_id}"
}

output "public_network_bastion_vm_id" {
  description = "The bastion virtual machine ID"
  value       = "${module.bastion.vm_ids[0]}"
}

output "public_network_bastion_private_ip" {
  description = "The bastion private ip address"
  value       = "${module.bastion.network_interface_private_ip}"
}

output "public_network_bastion_avset_id" {
  description = "The bastion availability set id"
  value       = "${module.bastion.availability_set_id}"
}

