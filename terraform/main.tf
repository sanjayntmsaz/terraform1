resource "azurerm_resource_group" "rgName" {
  name = var.resource_group_name
  location = var.resource_group_location
  tags = {
    "Env" = "DevTest"
  }
}
resource "azurerm_virtual_network" "vnet" {
        name = var.virtual_network_name
        resource_group_name = azurerm_resource_group.rgName.name
        location = azurerm_resource_group.rgName.location
        address_space = ["10.1.0.0/16"]
}
resource "azurerm_subnet" "websubnet" {
    name = var.subnet_name
    resource_group_name = azurerm_resource_group.rgName.name
    address_prefixes = [ "10.1.1.0/24" ]
    virtual_network_name = azurerm_virtual_network.vnet.name  
}
resource "azurerm_network_interface" "winvmnic" {
    name = var.network_interface_name
    resource_group_name = azurerm_resource_group.rgName.name
    location = azurerm_resource_group.rgName.location
    ip_configuration {
      name = "ipconfig1"
      subnet_id =   azurerm_subnet.websubnet.id
      private_ip_address_allocation = "Dynamic"
    }
  
}
resource "azurerm_windows_virtual_machine" "winvm" {
    name = "win1"
    resource_group_name = azurerm_resource_group.rgName.name
    location = azurerm_resource_group.rgName.location
    admin_username = "vmadmin"
    admin_password = "123#ntms123#"
    size = "Standard_Ds1_v2"
    network_interface_ids = [ azurerm_network_interface.winvmnic.id, ]
    os_disk {
      caching = "ReadWrite"
      storage_account_type = "StandardSSD_LRS"
    }
    source_image_reference {
       publisher = "MicrosoftWindowsServer"
       offer = "WindowsServer"
       sku =  "2019-datacenter-smalldisk"
       version = "latest"
    }
}