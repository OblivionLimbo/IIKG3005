variable "vm_nic_name" {
  type        = string
  description = "Network interface name"
}

variable "vm_subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "vm_name" {
  type        = string
  description = "Virtual machine name"
}

variable "pip_name" {
  type        = string
  description = "Public IP name"
}

variable "vm_username" {
  type        = string
  description = "Virtual machine username"
  sensitive   = true
}

variable "vm_password" {
  type        = string
  description = "Virtual machine password"
  sensitive   = true
}

variable common_tags {
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