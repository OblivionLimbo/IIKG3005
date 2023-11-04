variable "company" {
  type        = string
  description = "Company name"
  default     = "Company"
}

variable "project" {
  type        = string
  description = "Project name"
  default     = "Project"
}

variable "billing_code" {
  type        = string
  description = "Billing code"
  default     = "Billing"
}

variable "kv_rgname" {
  type        = string
  description = "Key Vault Resource Group Name"
  default     = "kv-rg"
}

variable "kv_location" {
  type        = string
  description = "location of the Key Vault"
  default     = "westeurope"
}

variable "kv_base_name" {
  type        = string
  description = "Name of the Key Vault"
  default     = "kv"
}

variable "sa_base_name" {
  type        = string
  description = "The name of the storage account"
  default     = "sa"
}

variable "sa_rg_name" {
  type        = string
  description = "The name of the resource group"
  default     = "sa-rg"
}

variable "sa_location" {
  type        = string
  description = "The Azure region where resources will be created"
  default     = "westeurope"
}

variable "sa_container_name" {
  type        = string
  description = "The name of the storage container"
  default     = "container"
}

variable "sa_account_tier" {
  type        = string
  description = "The storage account tier"
  default     = "Standard"
}

variable "sa_replication_type" {
  type        = string
  description = "The storage account replication type"
  default     = "GRS"
}

variable "vnet_rg_name" {
  type        = string
  description = "Resource group name"
  default     = "vnet-rg"
}

variable "vnet_rg_location" {
  type        = string
  description = "Resource group location"
  default     = "westeurope"
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network"
  default     = "vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space of the virtual network"
  default = [ "10.0.0.0/16" ]
}

variable "subnet_name" {
  type        = string
  description = "Name of the subnet"
  default     = "subnet"
}

variable "subnet_address_space" {
  type        = list(string)
  description = "Address space of the subnet"
  default = [ "10.0.0.0/24" ]
}

variable "nsg_name" {
  type        = string
  description = "Name of the network security group"
  default     = "nsg"
}

variable "vm_name" {
  type        = string
  description = "Name of the virtual machine"
  default     = "vm"
}

variable "vm_size" {
  type        = string
  description = "Size of the virtual machine"
  default     = "Standard_B2s"
}

variable "vm_rg_name" {
  type        = string
  description = "Resource group name"
  default     = "vm-rg"
}

variable "vm_rg_location" {
  type        = string
  description = "Resource group location"
  default     = "westeurope"
}

variable "vm_nic_name" {
  type        = string
  description = "Name of the network interface"
  default     = "vm-nic"
}

variable "pip_name" {
  type        = string
  description = "Name of the public IP address"
  default     = "vm-pip-name"
}

variable "vm_username" {
  type        = string
  description = "Username of the virtual machine"
  default     = "azureuser"
}

variable "vm_password" {
  type        = string
  description = "Password of the virtual machine"
  default    = "SPF535aLf&6!Ro^^Z7#"
}

variable "kv_sku_name" {
  type        = string
  description = "SKU name for the Key Vault"
  default     = "standard"
}

variable "my_ip" {
  type        = string
  description = "My IP address"
  default = "10.0.0.6"
}

variable "index_document" {
  type        = string
  description = "The name of the index document"
  default     = "index.html"
}

variable "source_content" {
  type        = string
  description = "The content of the index document"
  default     = "<h1>Made with Terraform - CI/CD pipeline</h1>"
}

variable "web_sa_name" {
  type        = string
  description = "The name of the web storage account"
  default     = "websa"
}