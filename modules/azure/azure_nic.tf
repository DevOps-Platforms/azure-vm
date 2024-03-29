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

resource "azurerm_network_interface" "nic" {
  depends_on = [
    azurerm_resource_group.vm,
  ]
  
  for_each = var.nics
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.rg

  ip_configuration {
    name                          = each.value.ipconfigname
    subnet_id                     = azurerm_subnet.general.id
    private_ip_address_allocation = each.value.privip

  }
}

