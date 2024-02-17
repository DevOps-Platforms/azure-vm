variable "vms" {
  type = map(object({
    name                  = string
    rg                    = string
    location              = string
    size                  = string
    adminuser             = string
    nicname               = string
    ssh                   = string
    caching               = string
    diskgb                = number
    diskname              = string
    storagetipe           = string
    publisher             = string
    offer                 = string
    sku                   = string
    version               = string
    
  }))
}

resource "azurerm_linux_virtual_machine" "vm" {
  for_each = var.vms
  name                  = each.value.name
  resource_group_name   = each.value.rg
  location              = each.value.location
  size                  = each.value.size
  admin_username        = var.admin_username
  network_interface_ids = [azurerm_network_interface.nic[each.key].id]
  admin_ssh_key {
    username   = var.admin_username
    public_key = var.public_key
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