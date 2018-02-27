provider "azurerm" {
  version = "~> 1.1"
}

provider "random" {
  version = "~> 1.0"
}

module "os" {
  source       = "./os"
  vm_os_simple = "${var.vm_os_simple}"
}

resource "azurerm_resource_group" "vm" {
  count    = "${var.nb_instances > 0 ? "1" : "0"}"
  name     = "${var.resource_group_name}"
  location = "${var.location}"
}

resource "random_id" "vm-sa" {
  count   = "${var.nb_instances > 0 ? "1" : "0"}"
  keepers = {
    vm_hostname = "${var.vm_hostname}"
  }

  byte_length = 6
}

resource "azurerm_storage_account" "vm-sa" {
  count                    = "${var.boot_diagnostics == "true" ? 1 : 0}"
  name                     = "bootdiag${lower(random_id.vm-sa.hex)}"
  resource_group_name      = "${azurerm_resource_group.vm.name}"
  location                 = "${var.location}"
  account_tier             = "${element(split("_", var.boot_diagnostics_sa_type),0)}"
  account_replication_type = "${element(split("_", var.boot_diagnostics_sa_type),1)}"
  tags                     = "${var.tags}"
}

resource "azurerm_virtual_machine" "vm-linux" {
  count                         = "${var.data_disk == "false" ? var.nb_instances : 0}"
  name                          = "${var.vm_hostname}-vm${var.nb_instances == 1 ? "" : "-${count.index}"}"
  location                      = "${var.location}"
  resource_group_name           = "${azurerm_resource_group.vm.name}"
  availability_set_id           = "${azurerm_availability_set.vm.id}"
  vm_size                       = "${var.vm_size}"
  network_interface_ids         = ["${element(azurerm_network_interface.vm.*.id, count.index)}"]
  delete_os_disk_on_termination = "${var.delete_os_disk_on_termination}"

  storage_image_reference {
    id        = "${var.vm_os_id}"
    publisher = "${var.vm_os_id == "" ? coalesce(var.vm_os_publisher, module.os.calculated_value_os_publisher) : ""}"
    offer     = "${var.vm_os_id == "" ? coalesce(var.vm_os_offer, module.os.calculated_value_os_offer) : ""}"
    sku       = "${var.vm_os_id == "" ? coalesce(var.vm_os_sku, module.os.calculated_value_os_sku) : ""}"
    version   = "${var.vm_os_id == "" ? var.vm_os_version : ""}"
  }

  storage_os_disk {
    name              = "${var.vm_hostname}-vm${var.nb_instances == 1 ? "" : "-${count.index}"}-osdisk"
    create_option     = "FromImage"
    caching           = "ReadWrite"
    managed_disk_type = "${var.os_sa_type}"
  }

  os_profile {
    computer_name  = "${var.vm_hostname}${var.nb_instances == 1 ? "" : "-${count.index}"}"
    admin_username = "${var.admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${file("${var.ssh_key}")}"
    }
  }

  tags = "${var.tags}"

  boot_diagnostics {
    enabled     = "${var.boot_diagnostics}"
    storage_uri = "${var.boot_diagnostics == "true" ? join(",", azurerm_storage_account.vm-sa.*.primary_blob_endpoint) : "" }"
  }
}

resource "azurerm_virtual_machine" "vm-linux-with-datadisk" {
  count                         = "${var.data_disk == "true" ? var.nb_instances : 0}"
  name                          = "${var.vm_hostname}-vm${var.nb_instances == 1 ? "" : "-${count.index}"}"
  location                      = "${var.location}"
  resource_group_name           = "${azurerm_resource_group.vm.name}"
  availability_set_id           = "${azurerm_availability_set.vm.id}"
  vm_size                       = "${var.vm_size}"
  network_interface_ids         = ["${element(azurerm_network_interface.vm.*.id, count.index)}"]
  delete_os_disk_on_termination = "${var.delete_os_disk_on_termination}"

  storage_image_reference {
    id        = "${var.vm_os_id}"
    publisher = "${var.vm_os_id == "" ? coalesce(var.vm_os_publisher, module.os.calculated_value_os_publisher) : ""}"
    offer     = "${var.vm_os_id == "" ? coalesce(var.vm_os_offer, module.os.calculated_value_os_offer) : ""}"
    sku       = "${var.vm_os_id == "" ? coalesce(var.vm_os_sku, module.os.calculated_value_os_sku) : ""}"
    version   = "${var.vm_os_id == "" ? var.vm_os_version : ""}"
  }

  storage_os_disk {
    name              = "${var.vm_hostname}-vm${var.nb_instances == 1 ? "" : "-${count.index}"}-osdisk"
    managed_disk_type = "${var.os_sa_type}"
    create_option     = "FromImage"
    caching           = "ReadWrite"
  }

  storage_data_disk {
    name                             = "${var.vm_hostname}-vm${var.nb_instances == 1 ? "" : "-${count.index}"}-datadisk"
    managed_disk_type                = "${var.data_sa_type}"
    create_option                    = "Empty"
    disk_size_gb                     = "${var.data_disk_size_gb}"
    caching                          = "${var.data_disk_caching}"
    lun                              = 0
    delete_data_disks_on_termination = false
  }

  os_profile {
    computer_name  = "${var.vm_hostname}${var.nb_instances == 1 ? "" : "-${count.index}"}"
    admin_username = "${var.admin_username}"
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      path     = "/home/${var.admin_username}/.ssh/authorized_keys"
      key_data = "${file("${var.ssh_key}")}"
    }
  }

  tags = "${var.tags}"

  boot_diagnostics {
    enabled     = "${var.boot_diagnostics}"
    storage_uri = "${var.boot_diagnostics == "true" ? join(",", azurerm_storage_account.vm-sa.*.primary_blob_endpoint) : "" }"
  }
}

resource "azurerm_availability_set" "vm" {
  count                        = "${var.nb_instances > 0 ? "1" : "0"}"
  name                         = "${var.vm_hostname}-availset"
  location                     = "${azurerm_resource_group.vm.location}"
  resource_group_name          = "${azurerm_resource_group.vm.name}"
  platform_update_domain_count = "${var.avset_update_domain_count}"
  platform_fault_domain_count  = "${var.avset_fault_domain_count}"
  managed                      = true
}

resource "azurerm_network_interface" "vm" {
  count                     = "${var.nb_instances}"
  name                      = "${var.vm_hostname}-nic${var.nb_instances == 1 ? "" : "-${count.index}"}"
  location                  = "${azurerm_resource_group.vm.location}"
  resource_group_name       = "${azurerm_resource_group.vm.name}"
  enable_ip_forwarding      = "${var.enable_ip_forwarding}"

  ip_configuration {
    name                          = "default-ip-config"
    subnet_id                     = "${var.subnet_id}"
    private_ip_address_allocation = "${var.private_ip_address_allocation}"
    private_ip_address            = "${var.private_ip_address_allocation == "static" ? element(var.private_ip_address_list,count.index) : "" }"
  }
}
