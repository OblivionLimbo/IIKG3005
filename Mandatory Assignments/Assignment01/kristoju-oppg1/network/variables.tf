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
  description = "Virtual network name"
  default     = "vnet"
}

variable "vnet_address_space" {
  type        = list(string)
  description = "Address space for the virtual network"
}

variable "vnet_dns_servers" {
  type        = list(string)
  description = "DNS servers for the virtual network"
}


variable "subnet_name" {
  type        = string
  description = "Subnet name"
  default     = "subnet"
}

variable "subnet_address_space" {
  type        = list(string)
  description = "Address space for the subnet"
}

variable "nsg_name" {
  type        = string
  description = "Network security group name"
  default     = "nsg"
}

variable "my_ip" {
  type        = string
  description = "My IP address"
}