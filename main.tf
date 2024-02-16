
provider "azurerm" {
  features {}
}

module "vm" {
  source = "./modules/vm"
  vms    = var.vms

}

module "nic" {
  source = "./modules/nic"
  nics   = var.nics

}

module "ip" {
  source = "./modules/ip"
  ips    = var.ips

}

resource "azurerm_resource_group" "vm" {
  name     = var.rg_name
  location = var.rg_location
}


resource "azurerm_virtual_network" "vm-network" {
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.rg_location
  resource_group_name = var.rg_name
}


resource "azurerm_subnet" "general" {
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_address_prefix]
}

resource "azurerm_network_security_group" "nsg" {
  name                = "vms-linux-nsg"
  location            = var.rg_location
  resource_group_name = var.rg_name

  security_rule {
    name                       = "allow_all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }
}


resource "azurerm_subnet_network_security_group_association" "nsga" {
  subnet_id                 = azurerm_subnet.general.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}
