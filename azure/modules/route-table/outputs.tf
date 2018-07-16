output "route_table_id" {
  description = "The id of route table created"
  value       = "${azurerm_route_table.route_table.id}"
}

output "route_table_name" {
  description = "The name of route table created"
  value       = "${azurerm_route_table.route_table.name}"
}
