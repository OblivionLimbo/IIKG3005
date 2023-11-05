resource "azurerm_resource_group" "openterra_rg" {
  name     = terraform.workspace == "default" ? "${var.rg_name}" : "${var.rg_name}-${local.workspaces_suffix}"
  location = var.rg_location
  tags     = local.common_tags
}

module "keyvault" {
  source            = "./keyvault"
  rg_name           = azurerm_resource_group.openterra_rg.name
  rg_location       = azurerm_resource_group.openterra_rg.location
  kv_base_name      = terraform.workspace == "default" ? "${var.kv_base_name}" : "${var.kv_base_name}-${local.workspaces_suffix}"
  sa_access_key     = module.StorageAccount.primary_access_key_output
  sa_base_name      = module.StorageAccount.storage_account_name_output
  vm_username       = var.vm_username
  vm_password       = var.vm_password
  vm_name           = terraform.workspace == "default" ? "${var.vm_name}" : "${var.vm_name}-${local.workspaces_suffix}"
  sa_accesskey_name = terraform.workspace == "default" ? "${var.sa_accesskey_name}" : "${var.sa_accesskey_name}-${local.workspaces_suffix}"
  kv_sku_name       = var.kv_sku_name
  common_tags       = local.common_tags
}

module "StorageAccount" {
  source            = "./storageaccount"
  rg_name           = azurerm_resource_group.openterra_rg.name
  rg_location       = azurerm_resource_group.openterra_rg.location
  sa_base_name      = terraform.workspace == "default" ? "${var.sa_base_name}" : "${var.sa_base_name}${local.workspaces_suffix}"
  sa_container_name = terraform.workspace == "default" ? "${var.sa_container_name}" : "${var.sa_container_name}-${local.workspaces_suffix}"
  index_document    = var.index_document
  source_content    = terraform.workspace == "default" ? "${var.source_content}" : "${var.source_content}${local.web_suffix}"
  web_sa_name       = terraform.workspace == "default" ? "${var.web_sa_name}" : "${var.web_sa_name}${local.workspaces_suffix}"
  common_tags       = local.common_tags
}

module "Network" {
  source      = "./network"
  rg_name     = azurerm_resource_group.openterra_rg.name
  rg_location = azurerm_resource_group.openterra_rg.location
  vnet_name   = terraform.workspace == "default" ? "${var.vnet_name}" : "${var.vnet_name}-${local.workspaces_suffix}"
  nsg_name    = terraform.workspace == "default" ? "${var.nsg_name}" : "${var.nsg_name}-${local.workspaces_suffix}"
  subnet_name = terraform.workspace == "default" ? "${var.subnet_name}" : "${var.subnet_name}-${local.workspaces_suffix}"
  common_tags = local.common_tags
}

module "VirtualMachine" {
  source       = "./virtualmachine"
  vm_name      = terraform.workspace == "default" ? "${var.vm_name}" : "${var.vm_name}-${local.workspaces_suffix}"
  rg_name      = azurerm_resource_group.openterra_rg.name
  rg_location  = azurerm_resource_group.openterra_rg.location
  vm_nic_name  = terraform.workspace == "default" ? "${var.vm_nic_name}" : "${var.vm_nic_name}-${local.workspaces_suffix}"
  vm_subnet_id = module.Network.subnet_id_output
  pip_name     = terraform.workspace == "default" ? "${var.pip_name}" : "${var.pip_name}-${local.workspaces_suffix}"
  vm_username  = var.vm_username
  vm_password  = var.vm_password
  common_tags  = local.common_tags
}

output "openterra_rg_name" {
  value = azurerm_resource_group.openterra_rg.name
}

output "openterra_rg_location" {
  value = azurerm_resource_group.openterra_rg.location
}

# apply all