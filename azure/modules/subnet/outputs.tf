output "subnet_id" {
  description = "The id of subnet created inside the vnet"
  value       = "${azurerm_subnet.subnet.id}"
}

output "subnet_name" {
  description = "The Name of the newly created subnet"
  value       = "${azurerm_subnet.subnet.name}"
}

output "subnet_address_prefix" {
  description = "The address prefix for the newly created subnet"
  value       = "${azurerm_subnet.subnet.address_prefix}"
}

output "subnet_nsg_id" {
  description = "The id of NSG created and associated to the newly subnet"
  value       = "${module.nsg.network_security_group_id}"
}

output "subnet_route_table_id" {
  description = "The id of route table created and associated to the newly subnet"
  value       = "${module.route_table.route_table_id}"
}
