# terraform-modules-linux-vm #

Deploys 1+ Linux Virtual Machines to your provided VNet
=======================================================

This Terraform module deploys Linux Virtual Machines in Azure and associate it for a subnet.

- Ability to specify a simple string to get the [latest marketplace image](https://docs.microsoft.com/cli/azure/vm/image?view=azure-cli-latest) using `var.vm_os_simple`
- All VMs use [managed disks](https://azure.microsoft.com/services/managed-disks/)
- VM nics attached to a single virtual network subnet of your choice via `var.vnet_subnet_id`.
- Enables to create and associate an IP public for each instance created via `var.enable_public_ip`. Default is `false`.

Simple Usage
-----

This contains the bare minimum options to be configured for the VM to be provisioned.  The entire code block provisions a Linux VM, but feel free to delete one or the other and corresponding outputs. The outputs are also not necessary to provision, but included to make it convenient to know the address to connect to the VMs after provisioning completes.

Provisions an Ubuntu Server 16.04-LTS VM using `vm_os_simple` to a new VNet.  All resources are provisioned into the default resource group called `test-linux-vm`.  The Ubuntu Server will use the ssh key found in the default location `~/.ssh/id_rsa.pub`.

```hcl
  module "linuxserver" {
    source              = "git::ssh://git@gitlab.neoway.com.br:10022/labs/terraform-modules.git//azure/modules/linux-vm"
    resource_group_name = "test-linux-vm"
    location            = "eastus"
    vm_os_simple        = "UbuntuServer"
    subnet_id           = "${module.subnet.subnet_id}"
  }
```

Advanced Usage
-----

The following example illustrates some of the configuration options available to deploy a virtual machine.

More specifically this provisions:

- Provisions two linux instances.
- Ubuntu 14.04 Server VMs using `vm_os_publisher`, `vm_os_offer` and `vm_os_sku` which is configured with:
- Additional tags are added to the resource group.
- Add one 64GB premium managed data disk.

```hcl 
  module "linuxservers" {
    source              = "Azure/compute/azurerm"
    resource_group_name = "test-linux-vms"
    location            = "eastus"
    vm_hostname         = "mylinuxvm"
    nb_instances        = "2"
    vm_os_publisher     = "Canonical"
    vm_os_offer         = "UbuntuServer"
    vm_os_sku           = "14.04.2-LTS"
    subnet_id           = "${module.subnet.subnet_id}"
    data_disk           = "true"
    data_disk_size_gb   = "64"
    data_sa_type        = "Premium_LRS"
    tags                = {
                            environment = "dev"
                            costcenter  = "it"
                          }
  }

  output "linux_vm_private_ips" {
    value = "${module.linuxservers.network_interface_private_ip}"
  }
```

Required Inputs
----
These variables must be set in the module block when using this module.

#### resource_group_name
Description: The name of the resource group in which the resources will be created

#### location
Description: The location/region where the virtual network is created. Changing this forces a new resource to be created.

#### subnet_id
Description: The subnet id of the virtual network where the virtual machines will reside.

Optional Inputs
----

These variables have default values and don't have to be set to use this module. You may set these variables to override their default values.

#### admin_username
Description: The admin username of the VM that will be deployed
 - default: "bootstrap"

#### ssh_key
Description: Path to the public key to be used for ssh access to the VM.  Only used with non-Windows vms and can be left as-is even if using Windows vms. If specifying a path to a certification on a Windows machine to provision a linux vm use the / in the path versus backslash. e.g. c:/home/id_rsa.pub
 - default: "~/.ssh/id_rsa.pub"

#### vm_size
Description: Specifies the size of the virtual machine.
 - default: "Standard_DS1_V2"

#### nb_instances
Description: Specify the number of vm instances
 - default: "1"

#### vm_hostname
Description: local name of the VM
 - default: "myvm"

#### os_sa_type
Description: Defines the type of storage account to be created. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS.
 - default: "Premium_LRS"

#### vm_os_simple
Description: Specify UbuntuServer, RHEL, openSUSE-Leap, CentOS, Debian, CoreOS and SLES to get the latest image version of the specified os.  Do not provide this value if a custom value is used for vm_os_publisher, vm_os_offer, and vm_os_sku.
 - default: "UbuntuServer"

#### vm_os_id
Description: The resource ID of the image that you want to deploy if you are using a custom image.
 - default: ""

#### vm_os_publisher
Description: The name of the publisher of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided.
 - default: ""

#### vm_os_offer
Description: The name of the offer of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided.
 - default: ""

#### vm_os_sku
Description: The sku of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided.
 - default: ""

#### vm_os_version
Description: The version of the image that you want to deploy. This is ignored when vm_os_id or vm_os_simple are provided.
 - default: "latest"

#### tags
Description: A map of the tags to use on the resources that are deployed with this module.
 - type: map
 - default: {}

#### enable_ip_forwarding
Description: Enables IP Forwarding on the NIC. Defaults to false.
 - default: "false"

#### enable_accelerated_networking
Description: Enables Azure Accelerated Networking using SR-IOV. Only certain VM instance sizes are supported. Defaults to false.
 - default: "false"

#### enable_public_ip
Description: Enables to create and associate an IP public for each instance created.
 - default: "false"

#### public_ip_address_allocation
Description: Defines how an IP address is assigned. Options are static or dynamic.
 - default: "dynamic"

#### public_ip_dns
Description: Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_instances. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string.
 - default: [ "" ]

#### private_ip_address_allocation
Description: Defines how an IP address is assigned. Options are static or dynamic.
 - default: "dynamic"

#### private_ip_address_list
Description: A list of static IP address.
 - default: [""]

#### delete_os_disk_on_termination
Description: Delete datadisk when machine is terminated
 - default: "true"

#### avset_update_domain_count
Description: Specifies the number of update domains that are used. Defaults to 5.
 - default: "5"

#### avset_fault_domain_count
Description: Specifies the number of fault domains that are used. Defaults to 3.
 - default: "3"

#### data_sa_type
Description: Defines the type of storage account to be created for data disk. Valid options are Standard_LRS, Standard_ZRS, Standard_GRS, Standard_RAGRS, Premium_LRS.
 - default: "Premium_LRS"

#### data_disk_size_gb
Description: Storage data disk size
 - default: ""

#### data_disk_caching
Description: Specifies the caching requirements for storage data disk
 - default: "ReadWrite"

#### data_disk
Description: Set to true to add a datadisk.
 - default: "false"

#### boot_diagnostics
Description: (Optional) Enable or Disable boot diagnostics
 - default: "false"

#### boot_diagnostics_sa_type
Description: (Optional) Storage account type for boot diagnostics
 - default: "Standard_LRS"

Outputs
----

#### vm_ids
Description: Virtual machine ids created.

#### network_interface_ids
Description: ids of the vm nics provisoned.

#### network_interface_private_ip
Description: private ip addresses of the vm nics

#### availability_set_id
Description: id of the availability set where the vms are provisioned.

#### public_ip_id
Description: id of the public ip address provisoned.

Authors
=======
Originally created by [David Tesar](https://github.com/Azure/terraform-azurerm-compute)

Changed by [Luciano Faustino](https:github.com/lborguetti) and [Paulo Pizarro](https://github.com/ppizarro).

License
=======

[MIT](LICENSE)
