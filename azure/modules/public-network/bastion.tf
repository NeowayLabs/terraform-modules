
resource "azurerm_availability_set" "availability_set" {
  name                         = "${var.env}-bastion-availset"
  location                     = "${var.location}"
  resource_group_name          = "${azurerm_resource_group.public.name}"
  platform_fault_domain_count  = "${var.bastion_platform_fault_domain_count}"
  platform_update_domain_count = "${var.bastion_platform_update_domain_count}"
  managed                      = true
}

resource "azurerm_network_interface" "network_interface" {
  name                 = "${var.env}-bastion-nic"
  location             = "${var.location}"
  resource_group_name  = "${azurerm_resource_group.public.name}"
  enable_ip_forwarding = "true"

  ip_configuration {
    name                          = "default-ip-config"
    subnet_id                     = "${module.subnet.subnet_id}"
    private_ip_address_allocation = "static"
    private_ip_address            = "${var.bastion_private_ip_address}"
  }
}

resource "azurerm_virtual_machine" "virtual_machine" {
  name                = "${var.env}-bastion-vm"
  location            = "${var.location}"
  resource_group_name = "${azurerm_resource_group.public.name}"

  availability_set_id              = "${azurerm_availability_set.availability_set.id}"
  delete_os_disk_on_termination    = "true"
  delete_data_disks_on_termination = "false"
  network_interface_ids            = ["${azurerm_network_interface.network_interface.id}"]
  primary_network_interface_id     = "${azurerm_network_interface.network_interface.id}"
  vm_size                          = "${var.bastion_virtual_machine_instance_size}"

  os_profile {
    admin_username = "${var.bastion_admin_username}"
    computer_name  = "${var.env}-bastion-vm"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.bastion_admin_username}/.ssh/authorized_keys"
      key_data = "${var.bastion_public_ssh_key}"
    }
  }

  storage_os_disk {
    name          = "${var.env}-bastion-vm-osdisk"
    create_option = "FromImage"
    disk_size_gb  = "${var.bastion_virtual_machine_disk_size}"
  }

  storage_image_reference {
    publisher = "${var.bastion_image_publisher}"
    offer     = "${var.bastion_image_offer}"
    sku       = "${var.bastion_image_sku}"
    version   = "${var.bastion_image_version}"
  }

  tags {
    env  = "${var.env}"
    role = "bastion"
  }
}
