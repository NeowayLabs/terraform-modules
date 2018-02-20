resource "azurerm_resource_group" "resource_group" {
  name     = "${var.env}-network"
  location = "${var.location}"
}

resource "azurerm_virtual_network" "virtual_network" {
  name                = "${var.env}-vnet"
  location            = "${var.location}"
  address_space       = "${var.address_space}"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_subnet" "gateway_application_cluster_subnet" {
  name                = "${var.env}-gateway-application-cluster-subnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  address_prefix            = "${var.gateway_application_cluster_subnet_address_prefix}"
  network_security_group_id = "${var.gateway_application_cluster_network_security_group_id}"
  virtual_network_name      = "${azurerm_virtual_network.virtual_network.name}"
}

resource "azurerm_subnet" "public_subnet" {
  name                = "${var.env}-public-subnet"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  address_prefix            = "${var.public_subnet_address_prefix}"
  network_security_group_id = "${azurerm_network_security_group.network_security_group.id}"
  route_table_id            = "${azurerm_route_table.route_table.id}"
  virtual_network_name      = "${azurerm_virtual_network.virtual_network.name}"
}

resource "azurerm_network_security_group" "network_security_group" {
  name     = "${var.env}-public-security-group"
  location = "${var.location}"

  resource_group_name = "${azurerm_resource_group.resource_group.name}"

  security_rule {
    name                       = "allow-private-subnets-to-peering-solution-delivery-services"
    priority                   = 3300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "${var.solution_delivery_address_prefix}"
  }

  security_rule {
    name                       = "allow-openvpn-cloud-blackops-to-bastion"
    priority                   = 3400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.openvpn_cloud_blackops_address_range}"
    destination_address_prefix = "${var.bastion_private_ip_address}"
  }

  security_rule {
    name                       = "allow-openvpn-cloud-gatekeepers-to-bastion"
    priority                   = 3500
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.openvpn_cloud_gatekeepers_address_range}"
    destination_address_prefix = "${var.bastion_private_ip_address}"
  }

  security_rule {
    name                       = "allow-private-subnets-to-nat-internet"
    priority                   = 3600
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "allow-internet-to-https-gateway-reverse-proxy"
    priority                   = 3700
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "${var.public_subnet_address_prefix}"
  }

  security_rule {
    name                       = "allow-internet-to-http-gateway-reverse-proxy"
    priority                   = 3800
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "${var.public_subnet_address_prefix}"
  }

  security_rule {
    name                       = "allow-alb-to-gateway-reverse-proxy"
    priority                   = 3900
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "44380"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "${var.public_subnet_address_prefix}"
  }

  security_rule {
    name                       = "allow-neoway-to-bastion"
    priority                   = 4000
    direction                  = "Inbound"
    access                     = "${var.bastion_neoway_ssh_access}"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "${var.bastion_neoway_ssh_ip_address}"
    destination_address_prefix = "${var.bastion_private_ip_address}"
  }
}

resource "azurerm_route_table" "route_table" {
  name     = "${var.env}-public-route-table"
  location = "${var.location}"

  resource_group_name = "${azurerm_resource_group.resource_group.name}"
}

resource "azurerm_route" "openvpn_cloud_blackops" {
  name                = "openvpn-cloud-blackops"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  route_table_name    = "${azurerm_route_table.route_table.name}"

  address_prefix         = "${var.openvpn_cloud_blackops_address_range}"
  next_hop_in_ip_address = "${var.openvpn_cloud_ip_address}"
  next_hop_type          = "VirtualAppliance"
}

resource "azurerm_route" "openvpn_cloud_gatekeepers" {
  name                = "openvpn-cloud-gatekeepers"
  resource_group_name = "${azurerm_resource_group.resource_group.name}"
  route_table_name    = "${azurerm_route_table.route_table.name}"

  address_prefix         = "${var.openvpn_cloud_gatekeepers_address_range}"
  next_hop_in_ip_address = "${var.openvpn_cloud_ip_address}"
  next_hop_type          = "VirtualAppliance"
}
