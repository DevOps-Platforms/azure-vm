variable "ips" {
  type = map(object({
    name     = string
    location = string
    rg       = string
    method   = string
    sku      = string
  }))
}

resource "azurerm_public_ip" "ips" {
  depends_on = [azurerm_resource_group.vm]
  for_each = var.ips
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.rg
  allocation_method   = each.value.method
  sku                 = each.value.sku
}