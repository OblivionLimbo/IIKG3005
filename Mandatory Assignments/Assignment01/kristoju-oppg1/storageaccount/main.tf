resource "random_string" "random_string" {
  length  = 5
  special = false
  upper   = false
  numeric = true
}

resource "azurerm_resource_group" "sa_rg" {
  name     = var.sa_rg_name
  location = var.sa_location
}

resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.sa_base_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.sa_rg.name
  location                 = azurerm_resource_group.sa_rg.location
  account_tier             = var.sa_account_tier
  account_replication_type = var.sa_replication_type
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.sa_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}
