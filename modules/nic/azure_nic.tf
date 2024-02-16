variable "nics" {
  type = map(object({
    name         = string
    location     = string
    rg           = string
    ipconfigname = string
    subnetid     = string
    privip       = string
    pubip        = string
  }))
}

resource "azurerm_network_interface" "nic" {
  for_each = var.nics
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.rg

  ip_configuration {
    name                          = each.value.ipconfigname
    subnet_id                     = each.value.subnetid
    private_ip_address_allocation = each.value.privip
    public_ip_address_id          = each.value.pubip
  }
}