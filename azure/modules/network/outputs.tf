output "network_vnet_id" {
  description = "The id of the newly created vNet"
  value       = "${module.vnet.vnet_id}"
}

output "network_vnet_name" {
  description = "The Name of the newly created vNet"
  value       = "${module.vnet.vnet_name}"
}

output "network_location" {
  description = "The location of the newly created vNet"
  value       = "${module.vnet.vnet_location}"
}

output "network_address_space" {
  description = "The address space of the newly created vNet"
  value       = "${module.vnet.vnet_address_space}"
}

output "network_subnets" {
  description = "The ids of subnets created inside the newly vNet"
  value       = "${module.vnet.vnet_subnets}"
}

output "network_nsgs" {
  description = "The ids of NSGs created inside the newly vNet"
  value       = "${modules.nsg.*.network_security_group_id}"
}

output "network_route_tables" {
  description = "The ids of route tables created inside the newly vNet"
  value       = "${modules.route_table.*.route_table_id}"
}

