
provider "azurerm" {
  features {}
}

module "azure" {
  source                  = "./modules/azure/"
  DEVOPS_AZURE_ADMIN_USER = var.DEVOPS_AZURE_ADMIN_USER
  DEVOPS_AZURE_PUBLIC_SSH = var.DEVOPS_AZURE_PUBLIC_SSH
  nics                    = var.nics
  vms                     = var.vms
}

variable "DEVOPS_AZURE_ADMIN_USER" {
  description = "Admin username"
  type        = string
  default     = null
}

variable "DEVOPS_AZURE_PUBLIC_SSH" {
  description = "Public SSH key"
  type        = string
  default     = null
}

resource "azurerm_resource_group" "vm" {
  name     = var.rg_name
  location = var.rg_location
}

resource "azurerm_public_ip" "ips" {
  depends_on = [azurerm_resource_group.vm]
  name                = "linux-jump-ip"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_virtual_network" "vm-network" {
  depends_on = [azurerm_resource_group.vm]
  name                = var.vnet_name
  address_space       = [var.vnet_address_space]
  location            = var.rg_location
  resource_group_name = var.rg_name
}

resource "azurerm_subnet" "general" {
  depends_on = [azurerm_virtual_network.vm-network]
  name                 = var.subnet_name
  resource_group_name  = var.rg_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.subnet_address_prefix]
}

variable "nics" {
  type = map(object({
    name         = string
    location     = string
    rg           = string
    ipconfigname = string
    subnetid     = string
    privip       = string
  }))
}

variable "vms" {
  type = map(object({
    name        = string
    rg          = string
    location    = string
    size        = string
    adminuser   = string
    nicname     = string
    ssh         = string
    caching     = string
    diskgb      = number
    diskname    = string
    storagetipe = string
    publisher   = string
    offer       = string
    sku         = string
    version     = string

  }))
}

# variable "ips" {
#   type = map(object({
#     name     = string
#     location = string
#     rg       = string
#     method   = string
#     sku      = string
#   }))
# }

resource "azurerm_network_security_group" "nsg" {
  depends_on = [azurerm_resource_group.vm]

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
  depends_on = [
    azurerm_subnet.general,
    azurerm_network_security_group.nsg
  ]
  subnet_id                 = azurerm_subnet.general.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}



