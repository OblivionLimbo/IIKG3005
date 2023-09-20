variable "company" {
    type = string
    description = "Company name"
}

variable "project" {
    type = string
    description = "Project name"
}

variable "billing_code" {
    type = string
    description = "Billing code"
}

variable "kv_rgname" {
    type = string
    description = "Key Vault Resource Group Name"
}

variable "kv_location" {
    type = string
    description = "location of the Key Vault"
}

variable "kv_base_name" {
    type = string
    description = "Name of the Key Vault"
}

variable "sa_base_name" {
    type = string
    description = "The name of the storage account"
}

variable "sa_rgname" {
    type = string
    description = "The name of the resource group"
}

variable "sa_location" {
    type = string
    description = "The Azure region where resources will be created"
}

variable "sa_container_name" {
    type = string
    description = "The name of the storage container"
}

variable "vnet_rg_name" {
    type = string
    description = "Resource group name"
}

variable "vnet_rg_location" {
    type = string
    description = "Resource group location"
}

variable "vnet_name" {
    type = string
    description = "Name of the virtual network"
}

variable "vnet_address_space" {
    type = list(string)
    description = "Address space of the virtual network"
}

variable "subnet_name" {
    type = string
    description = "Name of the subnet"
}

variable "subnet_address_space" {
    type = list(string)
    description = "Address space of the subnet"
}

variable "nsg_name" {
    type = string
    description = "Name of the network security group"
}

variable "nsg_rules" {
    type = list(object({
        name                       = string
        priority                   = number
        direction                  = string
        access                     = string
        protocol                   = string
        source_port_range          = string
        destination_port_range     = string
        source_address_prefix      = string
        destination_address_prefix = string
    }))
    description = "List of network security group rules"
}

variable "vm_name" {
    type = string
    description = "Name of the virtual machine"
}  

variable "vm_size" {
    type = string
    description = "Size of the virtual machine"
}

variable "vm_rg_name" {
    type = string
    description = "Resource group name"
}

variable "vm_rg_location" {
    type = string
    description = "Resource group location"
}

variable "vm_nic_name" {
    type = string
    description = "Name of the network interface"
}

variable "vm_nic_private_ip_address" {
    type = string
    description = "Private IP address of the network interface"
}

variable "vm_nic_public_ip_address" {
    type = string
    description = "Public IP address of the network interface"
}

variable "pip_name" {
    type = string
    description = "Name of the public IP address"
}