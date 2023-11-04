module "keyvault" {
  source        = "./keyvault"
  kv_rgname     = terraform.workspace == "default" ? "${var.kv_rgname}" : "${var.kv_rgname}-${local.workspaces_suffix}"
  kv_location   = var.kv_location
  kv_base_name  = terraform.workspace == "default" ? "${var.kv_base_name}" : "${var.kv_base_name}-${local.workspaces_suffix}"
  sa_access_key = module.StorageAccount.primary_access_key_output
  sa_base_name  = module.StorageAccount.storage_account_name_output
  vm_username   = var.vm_username
  vm_password   = var.vm_password
  common_tags   = local.common_tags
}

module "StorageAccount" {
  source            = "./storageaccount"
  sa_rg_name        = terraform.workspace == "default" ? "${var.sa_rg_name}" : "${var.sa_rg_name}-${local.workspaces_suffix}"
  sa_location       = var.sa_location
  sa_base_name      = terraform.workspace == "default" ? "${var.sa_base_name}" : "${var.sa_base_name}${local.workspaces_suffix}"
  sa_container_name = terraform.workspace == "default" ? "${var.sa_container_name}" : "${var.sa_container_name}-${local.workspaces_suffix}"
  index_document    = var.index_document
  source_content    = terraform.workspace == "default" ? "${var.source_content}" : "${var.source_content}${local.web_suffix}"
  web_sa_name       = terraform.workspace == "default" ? "${var.web_sa_name}" : "${var.web_sa_name}${local.workspaces_suffix}"
  common_tags       = local.common_tags
}

module "Network" {
  source           = "./network"
  vnet_rg_name     = terraform.workspace == "default" ? "${var.vnet_rg_name}" : "${var.vnet_rg_name}-${local.workspaces_suffix}"
  vnet_rg_location = var.vnet_rg_location
  vnet_name        = var.vnet_name
  nsg_name         = var.nsg_name
  subnet_name      = var.subnet_name
  common_tags      = local.common_tags
}

module "VirtualMachine" {
  source         = "./virtualmachine"
  vm_name        = terraform.workspace == "default" ? "${var.vm_name}" : "${var.vm_name}-${local.workspaces_suffix}"
  vm_rg_name     = terraform.workspace == "default" ? "${var.vm_rg_name}" : "${var.vm_rg_name}-${local.workspaces_suffix}"
  vm_rg_location = var.vm_rg_location
  vm_nic_name    = var.vm_nic_name
  vm_subnet_id   = module.Network.subnet_id_output
  pip_name       = var.pip_name
  vm_username    = var.vm_username
  vm_password    = var.vm_password
  common_tags    = local.common_tags
}

# Run terraform apply to create the resources.