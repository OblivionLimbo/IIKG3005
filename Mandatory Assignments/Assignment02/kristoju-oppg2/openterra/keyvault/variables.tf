variable "kv_base_name" {
  type        = string
  description = "Base name of the Key Vault"
  default     = "kv"
}

variable "sa_access_key" {
  type        = string
  description = "Storage account access key"
}

variable "sa_accesskey_name" {
  type = string
  description = "name of the storage account access key"
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

variable "vm_name" {
  type        = string
  description = "Name of the VM"
}

variable "kv_sku_name" {
  type        = string
  description = "SKU name for the Key Vault"
}

variable "common_tags" {
  description = "A map of common tags for resources."
  type        = map(string)
}

variable "rg_location" {
  type        = string
  description = "The Azure region where resources will be created"
}

variable "rg_name" {
  type        = string
  description = "The name of the resource group"
}