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
}


data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "kv_rg" {
  name     = var.kv_rgname
  location = var.kv_location
  tags     = var.common_tags
}

resource "azurerm_key_vault" "kv" {
  name                        = "${var.kv_base_name}${random_string.random_string.result}"
  location                    = azurerm_resource_group.kv_rg.location
  resource_group_name         = azurerm_resource_group.kv_rg.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "Get", "List", "Create", "Delete", "Recover", "Backup", "Restore", "UnwrapKey", "WrapKey", "Encrypt", "Decrypt",
    ]

    secret_permissions = [
      "Get", "Set", "Delete", "Purge", "Recover", "List", "Backup", "Restore",
    ]

    certificate_permissions = [
      "Get", "List", "Create", "Delete", "Import", "Update", "ManageContacts", "GetIssuers", "ListIssuers", "SetIssuers", "DeleteIssuers", "ManageIssuers", "Recover", "Purge",
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