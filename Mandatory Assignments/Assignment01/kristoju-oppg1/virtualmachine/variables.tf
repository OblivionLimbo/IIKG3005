variable "vm_name" {
  type        = string
  description = "Virtual machine name"
  default     = "vm"
}

variable "vm_size" {
  type        = string
  description = "Virtual machine size"
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
  description = "Network interface name"
  default     = "vm-nic"
}

variable "vm_nic_private_ip_address" {
  type        = string
  description = "Network interface private IP address"
}

variable "pip_name" {
  type        = string
  description = "Public IP name"
  default     = "vm-pip-name"
}

variable "vm_subnet_id" {
  type        = string
  description = "Subnet ID"
}

variable "vm_username" {
  type        = string
  description = "Virtual machine username"
}

variable "vm_password" {
  type        = string
  description = "Virtual machine password"
}