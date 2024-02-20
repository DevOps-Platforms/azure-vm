resource "azurerm_network_interface" "nic-jump" {
  depends_on = [azurerm_resource_group.vm]
  name                            = "linux_jump_server"
  location                        = var.rg_location
  resource_group_name             = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.general.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.jump-ip.id  
  }
}

resource "azurerm_public_ip" "jump-ip" {
  depends_on = [azurerm_resource_group.vm]
  name                = var.public_ip_name
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_security_group" "nsg-jump-server" {
  name                = "nsg-jump-server"
  location            = azurerm_resource_group.vm.location
  resource_group_name = azurerm_resource_group.vm.name

  security_rule {
    name                       = "SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface_security_group_association" "nsga-jump-server" {
  network_interface_id      = azurerm_network_interface.nic-jump.id
  network_security_group_id = azurerm_network_security_group.nsg-jump-server.id
}

resource "azurerm_linux_virtual_machine" "jump_server" {
  depends_on = [
    azurerm_resource_group.vm,
    azurerm_network_interface.nic-jump,
    azurerm_network_interface.nic-jump-port-22
  ]
  name                  = "linux-jump-server"
  resource_group_name   = azurerm_resource_group.vm.name
  location              = azurerm_resource_group.vm.location
  size                  = "Standard_DS1_v2"
  admin_username        = var.DEVOPS_AZURE_ADMIN_USER
  network_interface_ids = [
    azurerm_network_interface.nic-jump-port-22.id,
    azurerm_network_interface.nic-jump.id
    ]
  admin_ssh_key {
    username   = var.DEVOPS_AZURE_ADMIN_USER
    public_key = var.DEVOPS_AZURE_PUBLIC_SSH
  }
   os_disk {
    caching              = "ReadWrite"
    disk_size_gb         = 30
    name                 = "linux_jump_server"
    storage_account_type = "Standard_LRS"
  }
   source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

output "public_ip_address" {
  value = azurerm_public_ip.jump-ip.ip_address
}