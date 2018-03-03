
output "subnet_id" {
  description = "The id of subnet created inside the vnet"
  value       = "${module.subnet.subnet_id}"
}

output "subnet_name" {
  description = "The Name of the newly created subnet"
  value       = "${module.subnet.subnet_name}"
}

output "subnet_address_prefix" {
  description = "The address prefix for the newly created subnet"
  value       = "${module.subnet.subnet_address_prefix}"
}

output "subnet_nsg_id" {
  description = "The id of NSG created and associated to the newly subnet"
  value       = "${module.subnet.subnet_nsg_id}"
}

output "subnet_route_table_id" {
  description = "The id of route table created and associated to the newly subnet"
  value       = "${module.subnet.subnet_route_table_id}"
}

output "master_vm_ids" {
  description = "Master virtual machine ids created."
  value       = "${module.master.vm_ids}"
}

output "client_vm_ids" {
  description = "Client virtual machine ids created."
  value       = "${module.client.vm_ids}"
}

output "rack_1_data_vm_ids" {
  description = "Data virtual machine ids created in rack 1."
  value       = "${module.rack_1_data.vm_ids}"
}

output "rack_2_data_vm_ids" {
  description = "Data virtual machine ids created in rack 2."
  value       = "${module.rack_2_data.vm_ids}"
}

output "rack_3_data_vm_ids" {
  description = "Data virtual machine ids created in rack 3."
  value       = "${module.rack_3_data.vm_ids}"
}

output "rack_4_data_vm_ids" {
  description = "Data virtual machine ids created in rack 4."
  value       = "${module.rack_4_data.vm_ids}"
}

output "master_network_interface_ids" {
  description = "ids of the master vm nics provisoned."
  value       = "${module.master.network_interface_ids}"
}

output "client_network_interface_ids" {
  description = "ids of the client vm nics provisoned."
  value       = "${module.client.network_interface_ids}"
}

output "rack_1_data_network_interface_ids" {
  description = "ids of the data vm nics provisoned in rack 1."
  value       = "${module.rack_1_data.network_interface_ids}"
}

output "rack_2_data_network_interface_ids" {
  description = "ids of the data vm nics provisoned in rack 2."
  value       = "${module.rack_2_data.network_interface_ids}"
}

output "rack_3_data_network_interface_ids" {
  description = "ids of the data vm nics provisoned in rack 3."
  value       = "${module.rack_3_data.network_interface_ids}"
}

output "rack_4_data_network_interface_ids" {
  description = "ids of the data vm nics provisoned in rack 4."
  value       = "${module.rack_4_data.network_interface_ids}"
}

output "master_network_interface_private_ip" {
  description = "private ip addresses of the master vm nics"
  value       = "${module.master.network_interface_private_ip}"
}

output "client_network_interface_private_ip" {
  description = "private ip addresses of the client vm nics"
  value       = "${module.client.network_interface_private_ip}"
}

output "rack_1_data_network_interface_private_ip" {
  description = "private ip addresses of the data vm nics in rack 1"
  value       = "${module.rack_1_data.network_interface_private_ip}"
}

output "rack_2_data_network_interface_private_ip" {
  description = "private ip addresses of the data vm nics in rack 2"
  value       = "${module.rack_2_data.network_interface_private_ip}"
}

output "rack_3_data_network_interface_private_ip" {
  description = "private ip addresses of the data vm nics in rack 3"
  value       = "${module.rack_3_data.network_interface_private_ip}"
}

output "rack_4_data_network_interface_private_ip" {
  description = "private ip addresses of the data vm nics in rack 4"
  value       = "${module.rack_4_data.network_interface_private_ip}"
}

output "master_availability_set_id" {
  description = "id of the availability set where the master vms are provisioned."
  value       = "${module.master.availability_set_id}"
}

output "client_availability_set_id" {
  description = "id of the availability set where the client vms are provisioned."
  value       = "${module.client.availability_set_id}"
}

output "rack_1_data_availability_set_id" {
  description = "id of the availability set where the data vms are provisioned in rack 1."
  value       = "${module.rack_1_data.availability_set_id}"
}

output "rack_2_data_availability_set_id" {
  description = "id of the availability set where the data vms are provisioned in rack 2."
  value       = "${module.rack_2_data.availability_set_id}"
}

output "rack_3_data_availability_set_id" {
  description = "id of the availability set where the data vms are provisioned in rack 3."
  value       = "${module.rack_3_data.availability_set_id}"
}

output "rack_4_data_availability_set_id" {
  description = "id of the availability set where the data vms are provisioned in rack 4."
  value       = "${module.rack_4_data.availability_set_id}"
}

