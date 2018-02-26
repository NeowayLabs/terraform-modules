# terraform-modules-linux-vm #

This Terraform module deploys Linux Virtual Machines in Azure and associate it for a subnet.

Deploys 1+ Linux Virtual Machines to your provided VNet
=======================================================

This Terraform module deploys Virtual Machines in Azure with the following characteristics:

- Ability to specify a simple string to get the [latest marketplace image](https://docs.microsoft.com/cli/azure/vm/image?view=azure-cli-latest) using `var.vm_os_simple`
- All VMs use [managed disks](https://azure.microsoft.com/services/managed-disks/)
- VM nics attached to a single virtual network subnet of your choice via `var.vnet_subnet_id`.

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

Authors
=======
Originally created by [David Tesar](http://github.com/dtzar)

Changed by [Luciano Faustino](https:github.com/lborguetti) and [Paulo Pizarro](https://github.com/ppizarro).

License
=======

[MIT](LICENSE)
