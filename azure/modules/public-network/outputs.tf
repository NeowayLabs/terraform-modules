output "vnet_id" {
  description = "The id of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.id}"
}

output "vnet_name" {
  description = "The Name of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.name}"
}

output "vnet_address_space" {
  description = "The address space of the newly created vNet"
  value       = "${azurerm_virtual_network.vnet.address_space}"
}

output "public_network_location" {
  description = "The location of the public network"
  value       = "${azurerm_virtual_network.vnet.location}"
}

output "public_network_subnet_id" {
  description = "The id of public subnet"
  value       = "${azurerm_subnet.subnet.id}"
}

output "public_network_subnet_name" {
  description = "The Name of the public subnet"
  value       = "${azurerm_subnet.subnet.name}"
}

output "public_network_subnet_prefix" {
  description = "The address prefix for the public subnet"
  value       = "${azurerm_subnet.subnet.address_prefix}"
}

output "public_network_nsg_id" {
  description = "The id of the public NSG"
  value       = "${module.nsg.network_security_group_id}"
}

output "public_network_route_table_id" {
  description = "The id of the public route table"
  value       = "${module.route_table.route_table_id}"
}

