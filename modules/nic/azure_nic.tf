variable "nics" {
  type = map(object({
    name                            = string
    location                        = string
    resource_group_name             = string
    ip_configuration {
      name                          = string
      subnet_id                     = string
      private_ip_address_allocation = string
      public_ip_address_id          = string
    }
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