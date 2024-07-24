variable "resource_group_name" {
    description = "O nome do grupo de recursos"
    type        = string
    default     = "createVM-resources"
}

variable "location" {
    description = "A localização do grupo de recursos"
    type        = string
    default     = "East US 2"
}

variable "admin_username" {
    description = "O nome de usuário administrador para a VM"
    type        = string
    default     = "Admin"
}

variable "admin_password" {
    description = "A senha do administrador para a VM"
    type        = string
    default     = "Eaelucas@123"
}
