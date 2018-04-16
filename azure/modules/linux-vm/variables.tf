variable "resource_group_name" {
  description = "The name of the resource group in which the resources will be created"
}

variable "location" {
  description = "The location/region where the virtual network is created. Changing this forces a new resource to be created."
}

variable "subnet_id" {
  description = "The subnet id of the virtual network where the virtual machines will reside."
}

variable "admin_username" {
  description = "The admin username of the VM that will be deployed"
  default     = "bootstrap"
}

variable "ssh_key" {
  description = "Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub"
  default     = "~/.ssh/id_rsa.pub"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_DS1_V2"
}

variable "nb_instances" {
  description = "Specify the number of vm instances"
  default     = "1"
}

variable "vm_hostname" {
  description = "local name of the VM"
  default     = "myvm"
}

variable "os_sa_type" {
  description = "Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
  default     = "Premium_LRS"
}

variable "vm_os_simple" {
  description = "Specify UbuntuServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os.  Do not provide this value if a custom value is used for vm_os_publisher, vm_os_offer, and vm_os_sku."
  default     = "UbuntuServer"
}

variable "vm_os_id" {
  description = "The resource ID of the image that you want to deploy if you are using a custom image."
  default     = ""
}

variable "vm_os_publisher" {
  description = "The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_offer" {
  description = "The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_sku" {
  description = "The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = ""
}

variable "vm_os_version" {
  description = "The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided."
  default     = "latest"
}

variable "tags" {
  type        = "map"
  description = "A map of the tags to use on the resources that are deployed with this module."

  default = {
  }
}

variable "enable_ip_forwarding" {
  description = "Enables IP Forwarding on the NIC. Defaults to false."
  default = "false"
}

variable "enable_accelerated_networking" {
  description = "Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. Defaults to false."
  default = "false"
}

variable "enable_public_ip" {
  description = "Enables to create and associate an IP public for each instance created."
  default     = "false"
}

variable "public_ip_address_allocation" {
  description = "Defines how an IP address is assigned. Options are static or dynamic."
  default     = "dynamic"
}

variable "public_ip_dns_list" {
  description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_instances. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
  default     = [""]
}

variable "private_ip_address_allocation" {
  description = "Defines how an IP address is assigned. Options are static or dynamic."
  default     = "dynamic"
}

variable "private_ip_address_list" {
  description = "A list of static IP address."
  default = [""]
}

variable "delete_os_disk_on_termination" {
  description = "Delete datadisk when machine is terminated"
  default     = "true"
}

variable "avset_update_domain_count" {
  description = "Specifies the number of update domains that are used. Defaults to 5."
  default = "5"
}

variable "avset_fault_domain_count" {
  description = "Specifies the number of fault domains that are used. Defaults to 3."
  default = "3"
}

variable "data_sa_type" {
  description = "Defines the type of storage account to be created for data disk. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS."
  default     = "Premium_LRS"
}

variable "data_disk_size_gb" {
  description = "Storage data disk size"
  default     = ""
}

variable "data_disk_caching" {
  description = "Specifies the caching requirements for storage data disk"
  default     = "ReadWrite"
}

variable "data_disk" {
  type        = "string"
  description = "Set to true to add a datadisk."
  default     = "false"
}

variable "boot_diagnostics" {
  description = "(Optional) Enable or Disable boot diagnostics"
  default     = "false"
}

variable "boot_diagnostics_sa_type" {
  description = "(Optional) Storage account type for boot diagnostics"
  default     = "Standard_LRS"
}
