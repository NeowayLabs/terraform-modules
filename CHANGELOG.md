## v0.1.0 (2018-07-16)

### Breaking changes

Updating linux-vm module to this version forces a new VM and data disk to be created. CAUTION!

### Improvements

* [#2](https://gitlab.neoway.com.br/labs/terraform-modules/issues/2) - Added support to create linux VMs with more than one data disk
* Required 1.9.0 version for azure provider

## v0.0.2 (2018-04-17)

### Improvements

* [#1](https://gitlab.neoway.com.br/labs/terraform-modules/issues/1) - Added support to create linux VMs whith a public IP 
* Added dns_servers variable for public-network module
* VMs name will be appended always with a suffix with the vm number even for counts of 1

### Fixes

* Removed resource group creation from within vnet and vm modules
 
## v0.0.1 (2018-03-04)

### Features:

* **elastic:**
* **public-network:**
* **linux-vm:**
* **vnet:**
* **nsg:**
* **route-table:**
* **subnet:**
