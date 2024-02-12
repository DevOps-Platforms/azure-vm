
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "" {
  name     = "terraform-example"
  location = "East US"  # Altere para a localização desejada
}

# Defina a rede virtual
resource "azurerm_virtual_network" "example" {
  name                = "terraform-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Defina as sub-redes
resource "azurerm_subnet" "example" {
  name                 = "subnet1"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Defina as configurações das máquinas virtuais
resource "azurerm_linux_virtual_machine" "example" {
  count                 = 3
  name                  = "example-vm-${count.index}"
  resource_group_name   = azurerm_resource_group.example.name
  location              = azurerm_resource_group.example.location
  size                  = "Standard_DS1_v2"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.example[count.index].id]
  admin_ssh_key {
    username   = "adminuser"
    public_key = var.azure_ssh_public_key  # Use a variável para a chave pública SSH
  }
}

# Defina as interfaces de rede para as VMs
resource "azurerm_network_interface" "example" {
  count               = 3
  name                = "example-nic-${count.index}"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Permita o tráfego entre as VMs no nível do grupo de segurança de rede
resource "azurerm_network_security_group" "example" {
  name                = "example-nsg"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

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

# Associe o grupo de segurança de rede às sub-redes
resource "azurerm_subnet_network_security_group_association" "example" {
  subnet_id                 = azurerm_subnet.example.id
  network_security_group_id = azurerm_network_security_group.example.id
}
