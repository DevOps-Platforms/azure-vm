
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "vm" {
  name     = "lab_vm"
  location = "East US"
  }


resource "azurerm_virtual_network" "vm-network" {
  name                = "vm-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
}


resource "azurerm_subnet" "subnet1" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.vm.name
  virtual_network_name = azurerm_virtual_network.vm-network.name
  address_prefixes     = ["10.0.1.0/24"]
}


resource "azurerm_linux_virtual_machine" "vm" {
  count                 = 3
  name                  = "linux-vm-${count.index}"
  resource_group_name   = azurerm_resource_group.vm.name
  location              = azurerm_resource_group.vm.location
  size                  = "Standard_DS1_v2"
  admin_username        = var.DEVOPS_AZURE_ADMIN_USER
  network_interface_ids = [azurerm_network_interface.nic[count.index].id]
  admin_ssh_key {
    username   = var.DEVOPS_AZURE_ADMIN_USER
    public_key = var.DEVOPS_AZURE_PUBLIC_SSH
  }
   os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = 30
    name                 = "linux_vm_lab-${count.index}"
    storage_account_type = "Standard_LRS"
  }
   source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}


resource "azurerm_network_interface" "nic" {
  count               = 3
  name                = "linux-vm-nic-${count.index}"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet1.id
    private_ip_address_allocation = "Dynamic"
  }
}


resource "azurerm_network_security_group" "nsg" {
  name                = "vms-linux-nsg"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

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
  subnet_id                 = azurerm_subnet.subnet1.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "bastion_ip" {
  name                = "bastion-vm-linux"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_bastion_host" "bastion_host" {
  name                = "bastion-host-vm-linux"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.subnet1.id
    public_ip_address_id = azurerm_public_ip.bastion_ip.id
  }
}
