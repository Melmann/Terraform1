resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${var.prefix}-rg"
}
module "Vnet" {
  source      = "./Modules/Network"
  prefix      = "Terraform_QS"
  resource_g  = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
}
module "VM" {
  my_terraform_nic_id= module.Vnet.backend_interface
  source      = "./Modules/Vm"
  prefix      = "TerraformQS"
  resource_g  = azurerm_resource_group.rg.name
  rg_location = azurerm_resource_group.rg.location
  depends_on = [ module.Vnet ]
}