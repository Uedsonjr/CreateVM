provider "azurerm" {
    features {}
}

# Criação do Resource Group para todos os recursoster
resource "azurerm_resource_group" "createVM" {
    name     = var.resource_group_name
    location = var.location
}

# Criação da VN
resource "azurerm_virtual_network" "vnet" {
    name                = "createVM-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = azurerm_resource_group.createVM.location
    resource_group_name = azurerm_resource_group.createVM.name
}

# Criação da Subnet
resource "azurerm_subnet" "subnet" {
    name                 = "createVM-subnet"
    resource_group_name  = azurerm_resource_group.createVM.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes     = ["10.0.1.0/24"]
}

# Criação da interface
resource "azurerm_network_interface" "nic" {
    name                = "createVM-nic"
    location            = azurerm_resource_group.createVM.location
    resource_group_name = azurerm_resource_group.createVM.name

    ip_configuration {
        name                          = "internal"
        subnet_id                     = azurerm_subnet.subnet.id
        private_ip_address_allocation = "Dynamic"
    }  
}

# Criação do IP público do projeto
resource "azurerm_public_ip" "vm_public_ip" {
    name                = "createVM-public-ip"
    location            = azurerm_resource_group.createVM.location
    resource_group_name = azurerm_resource_group.createVM.name
    allocation_method   = "Dynamic"
}

# Criação da máquina virtual
resource "azurerm_virtual_machine" "vm" {
    name                  = "createVM-vm"
    location              = azurerm_resource_group.createVM.location
    resource_group_name   = azurerm_resource_group.createVM.name
    network_interface_ids = [azurerm_network_interface.nic.id]
    vm_size               = "Standard_B1s"

    storage_os_disk {
        name              = "createVM-os-disk"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "24.04-LTS"
        version   = "latest"
    }

    os_profile {
        computer_name  = "createVM-vm"
        admin_username = var.admin_username
        admin_password = var.admin_password

        custom_data = file("start_docker.sh")
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }
}

# Saída do ip público, publicando valor
output "public_ip" {
    value = azurerm_public_ip.vm_public_ip.ip_address
}

# Saída do id da VM, publicando valor
output "vm_id" {
    description = "O ID da máquina virtual"
    value       = azurerm_virtual_machine.vm.id
}
