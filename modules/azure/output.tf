output "public_ips" {
  value = azurerm_public_ip.ips[*].ip_address
}
