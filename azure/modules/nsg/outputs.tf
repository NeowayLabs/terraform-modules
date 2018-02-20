output "nsg_id" {
  description = "The id of the newly created nsg"
  value       = "${azurerm_network_security_group.nsg.id}"
}

output "nsg_name" {
  description = "The Name of the newly created nsg"
  value       = "${azurerm_network_security_group.nsg.name}"
}

output "nsg_location" {
  description = "The location of the newly created nsg"
  value       = "${azurerm_network_security_group.nsg.location}"
}

