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

# resource "azurerm_network_interface" "nic" {
#   depends_on = [
#     azurerm_resource_group.vm, 
#     azurerm_public_ip.ips
#   ]
  
#   for_each = var.nics
#   name                            = each.value.name
#   location                        = each.value.location
#   resource_group_name             = each.value.rg

#   ip_configuration {
#     name                          = each.value.ipconfigname
#     subnet_id                     = azurerm_subnet.general.id
#     private_ip_address_allocation = each.value.privip
#     public_ip_address_id          = azurerm_public_ip.ips.id
#   }
# }
resource "azurerm_network_interface" "nic" {
  depends_on = [
    azurerm_resource_group.vm, 
    azurerm_public_ip.ips
  ]
  
  for_each = var.nics
  name                            = each.value.name
  location                        = each.value.location
  resource_group_name             = each.value.rg

  ip_configuration {
    name                          = each.value.ipconfigname
    subnet_id                     = azurerm_subnet.general.id
    private_ip_address_allocation = each.value.privip
    
    public_ip_address_id = each.key == var.public_ip_nic_key ? azurerm_public_ip.ips[var.public_ip_nic_key].id : null

  }
}

