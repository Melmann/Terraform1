output "backend_interface" {
  value       = azurerm_network_interface.my_terraform_nic.id
  description = "Backend interface ID "
}