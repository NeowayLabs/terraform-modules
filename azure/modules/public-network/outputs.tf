output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = "${module.vnet.vnet_id}"
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = "${module.vnet.vnet_name}"
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
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

output "public_network_subnet_prefix" {
  description = "The address prefix for the public subnet"
  value       = "${module.subnet.subnet_prefix}"
}

output "public_network_nsg_id" {
  description = "The id of the public NSG"
  value       = "${module.subnet.subnet_nsg_id}"
}

output "public_network_route_table_id" {
  description = "The id of the public route table"
  value       = "${module.subnet.subnet_route_table_id}"
}

