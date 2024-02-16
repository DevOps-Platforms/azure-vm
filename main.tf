
provider "azurerm" {
  features {}
}

module "vm" {
  source = "./modules/vm"
  vms    = var.vms

}

variable "vms" {
  type = map(object({
    name                  = string
    resource_group_name   = string
    location              = string
    size                  = number
    admin_username        = string
    network_interface_ids = string
    node_count            = number
    resource_name         = string
    username              = string
    public_key            = string
    caching               = string
    disk_size_gb          = number
    diskname              = string
    storage_account_type  = string
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string

  }))
}

module "nic" {
  source = "./modules/nic"
  nics   = var.nics

}

variable "nics" {
  type = map(object({
    name                          = string
    location                      = string
    resource_group_name           = string
    ipconfigname                  = string
    subnet_id                     = string
    private_ip_address_allocation = string
    public_ip_address_id          = string
  }))
}

module "ip" {
  source = "./modules/ip"
  ips    = var.ips

}

variable "ips" {
  type = map(object({
    name                = string
    location            = string
    resource_group_name = string
    allocation_method   = string
    sku                 = string
  }))
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
