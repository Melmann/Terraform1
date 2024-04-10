# Create virtual network
resource "azurerm_virtual_network" "my_terraform_network" {
  name                = "VNET-${var.prefix}"
  address_space       = ["10.0.0.0/16"]
  location            = var.rg_location
  resource_group_name = var.resource_g
}

# Create subnet
resource "azurerm_subnet" "my_terraform_subnet" {
  name                 = "SUBNET-${var.prefix}"
  resource_group_name  = var.resource_g
  virtual_network_name = azurerm_virtual_network.my_terraform_network.name
  address_prefixes     = ["10.0.1.0/24"]
}

# Create public IPs
resource "azurerm_public_ip" "my_terraform_public_ip" {
  name                = "PUBLIC-IP-${var.prefix}"
  location            = var.rg_location
  resource_group_name = var.resource_g
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rules
resource "azurerm_network_security_group" "my_terraform_nsg" {
  name                = "NSG-${var.prefix}"
  location            = var.rg_location
  resource_group_name = var.resource_g

  security_rule {
    name                       = "RDP"
    priority                   = 1000
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "WEB"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "my_terraform_nic" {
  name                = "NIC-${var.prefix}"
  location            = var.rg_location
  resource_group_name = var.resource_g

  ip_configuration {
    name                          = "my_nic_configuration"
    subnet_id                     = azurerm_subnet.my_terraform_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.my_terraform_public_ip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.my_terraform_nic.id
  network_security_group_id = azurerm_network_security_group.my_terraform_nsg.id
}