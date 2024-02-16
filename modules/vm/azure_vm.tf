variable "vms" {
  type = map(object({
    name         = string
    resource_group_name   = string
    location              = string
    size     = number
    admin_username  = string
    network_interface_ids = string
    node_count   = number
    resource_name = string
    admin_ssh_key {
      username   = string
      public_key = string
    }
    os_disk {
      caching              = string
      disk_size_gb         = number
      name                 = string
      storage_account_type = string
    }
    source_image_reference {
      publisher = string
      offer     = string
      sku       = string
      version   = string
    }
  }))
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms
  name                  = each.value.name
  resource_group_name   = each.value.rg
  location              = each.value.location
  size                  = each.value.size
  admin_username        = each.value.adminuser
  network_interface_ids = each.value.nicname
  admin_ssh_key {
    username   = each.value.adminuser
    public_key = each.value.ssh
  }
   os_disk {
    caching              = each.value.caching
    disk_size_gb         = each.value.diskgb
    name                 = each.value.diskname
    storage_account_type = each.value.storagetipe
  }
   source_image_reference {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
    version   = each.value.version
  }
}