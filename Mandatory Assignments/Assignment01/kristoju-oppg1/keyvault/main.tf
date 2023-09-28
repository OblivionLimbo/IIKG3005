#Azure Key Vault with the following secrets: 
#  - A secret holding the VM username and password
#  - A secret holding the Storage Account Access Key

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = true
      recover_soft_deleted_key_vaults = true
    }
  }
}

resource "random_string" "random_string" {
  length  = 5
  special = false
  upper   = false
  numeric = true
}

data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "kv_rg" {
  name     = var.kv_rgname
  location = var.kv_location
}

resource "azurerm_key_vault" "kv" {
  name                        = "${var.kv_base_name}-${random_string.random_string.result}"
  location                    = azurerm_resource_group.kv_rg.location
  resource_group_name         = azurerm_resource_group.kv_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = var.kv_sku_name

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get",
      "List",
      "Create",
    ]

    secret_permissions = [
      "Get",
      "Set",
      "Delete",
      "Purge",
      "Recover",
      "List",
    ]

    certificate_permissions = [ 
      "Get",
      "List",
     ]
  }
}

resource "azurerm_key_vault_secret" "sa_accesskey" {
  name         = "sa-accesskey"
  value        = var.sa_access_key
  key_vault_id = azurerm_key_vault.kv.id
  depends_on = [
    var.sa_base_name
  ]
}

resource "azurerm_key_vault_secret" "vm_username" {
  name         = "vm-username"
  value        = var.vm_username
  key_vault_id = azurerm_key_vault.kv.id
}

resource "azurerm_key_vault_secret" "vm_password" {
  name         = "vm-password"
  value        = var.vm_password
  key_vault_id = azurerm_key_vault.kv.id
}