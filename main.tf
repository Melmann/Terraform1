resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "RG-${var.prefix}"
}
module "Vnet" {
  source      = "./Modules/Network"
  prefix      = "${var.prefix}"
  resource_g  = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
}
module "VM" {
  my_terraform_nic_id= module.Vnet.backend_interface
  source      = "./Modules/Vm"
  prefix      = "${var.prefix}"
  resource_g  = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
  depends_on = [ module.Vnet, azurerm_resource_group.rg  ]
}