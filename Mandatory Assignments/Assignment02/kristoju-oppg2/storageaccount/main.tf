resource "random_string" "random_string" {
  length  = 5
  special = false
  upper   = false
}

resource "azurerm_resource_group" "sa_rg" {
  name     = var.sa_rg_name
  location = var.sa_location

  tags = var.common_tags
}

resource "azurerm_storage_account" "sa" {
  name                     = "${lower(var.sa_base_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.sa_rg.name
  location                 = azurerm_resource_group.sa_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "azurerm_storage_container" "storage_container" {
  name                  = var.sa_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_account" "sa_web" {
  name                     = "${lower(var.web_sa_name)}${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.sa_rg.name
  location                 = azurerm_resource_group.sa_rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  static_website {
    index_document = var.index_document
  }
}

resource "azurerm_storage_blob" "index_html" {
  name                   = var.index_document
  storage_account_name   = azurerm_storage_account.sa_web.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source_content         = var.source_content
}

# Destroy

output "primary_web_endpoint" {
  value = azurerm_storage_account.sa_web.primary_web_endpoint
}