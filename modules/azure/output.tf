output "public_ip_for_instance" {
  value = {
    for key, value in azurerm_public_ip.ips : 
    key => value.ip_address if contains(keys(var.ips), key) && var.ips[key].name == value.name
  }
}
