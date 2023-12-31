variable "sa_base_name" {
  type        = string
  description = "The name of the storage account"
}

variable "sa_container_name" {
  type        = string
  description = "The name of the storage container"
}

variable "index_document" {
  type        = string
  description = "The name of the index document"
}

variable "source_content" {
  type        = string
  description = "The source content"
}

variable "web_sa_name" {
  type        = string
  description = "The name of the web storage account"
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