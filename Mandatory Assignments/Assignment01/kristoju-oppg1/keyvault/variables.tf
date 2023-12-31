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
  description = "Base name of the Key Vault"
  default     = "kv"
}

variable "sa_access_key" {
  type        = string
  description = "Storage account access key"
}

variable "sa_base_name" {
  type        = string
  description = "base storage account name"
  default     = "sa"
}

variable "vm_password" {
  type        = string
  description = "Password for the VM"
}

variable "vm_username" {
  type        = string
  description = "Username for the VM"
}

variable "kv_sku_name" {
  type        = string
  description = "SKU name for the Key Vault"
  default     = "standard"
}