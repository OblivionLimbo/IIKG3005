terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "keyvault" {
  source            = "./keyvault"
  kv_rgname         = var.kv_rgname
  kv_location       = var.kv_location
  kv_base_name      = var.kv_base_name
  kv_sku_name       = var.kv_sku_name
  sa_access_key     = module.StorageAccount.primary_access_key_output
  sa_base_name      = module.StorageAccount.storage_account_name_output
  vm_username       = var.vm_username
  vm_password       = var.vm_password
}

module "StorageAccount" {
  source            = "./storageaccount"
  sa_rg_name         = var.sa_rg_name
  sa_location       = var.sa_location
  sa_base_name      = var.sa_base_name
  sa_container_name = var.sa_container_name
  sa_account_tier   = var.sa_account_tier
  sa_replication_type = var.sa_replication_type
}

module "Network" {
  source               = "./network"
  vnet_rg_name         = var.vnet_rg_name
  vnet_rg_location     = var.vnet_rg_location
  vnet_name            = var.vnet_name
  vnet_address_space   = var.vnet_address_space
  vnet_dns_servers     = var.vnet_dns_servers
  nsg_name             = var.nsg_name
  subnet_name          = var.subnet_name
  subnet_address_space = var.subnet_address_space
  my_ip                = var.my_ip
}

module "VirtualMachine" {
  source                    = "./virtualmachine"
  vm_name                   = var.vm_name
  vm_rg_name                = var.vm_rg_name
  vm_rg_location            = var.vm_rg_location
  vm_nic_name               = var.vm_nic_name
  vm_size                   = var.vm_size
  pip_name                  = var.pip_name
  vm_username               = module.keyvault.keyvault_secret_password
  vm_password               = module.keyvault.keyvault_secret_username
  vm_subnet_id              = module.Network.subnet_id_output
}

