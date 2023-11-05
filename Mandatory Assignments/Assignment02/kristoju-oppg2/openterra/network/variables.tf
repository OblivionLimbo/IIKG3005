variable "vnet_name" {
  type        = string
  description = "Virtual network name"
}

variable "nsg_name" {
  type        = string
  description = "Network security group name"
}

variable "subnet_name" {
  type        = string
  description = "Subnet name"
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