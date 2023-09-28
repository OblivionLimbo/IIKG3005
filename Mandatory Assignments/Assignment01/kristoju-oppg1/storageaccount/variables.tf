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