resource "azurerm_windows_virtual_machine" "main" {
  name                  = "VM-${var.prefix}"
  admin_username        = "azureuser"
  admin_password        = "Welcome2021!" #some nice best practices in ntt XD 
  location              = var.rg_location
  resource_group_name   = var.resource_g
  network_interface_ids = [var.my_terraform_nic_id]
  size                  = "Standard_DS1_v2"

  os_disk {
    name                 = "myOsDisk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2022-datacenter-azure-edition"
    version   = "latest"
  }

}

resource "azurerm_virtual_machine_extension" "iis-vm-extension" {
  name                 = "IIS-${var.prefix}"
  virtual_machine_id   = azurerm_windows_virtual_machine.main.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.9"

  settings = <<SETTINGS
    { 
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    } 
  SETTINGS
}