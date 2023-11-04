output "keyvault_name" {
  value = azurerm_key_vault.kv.name
}
output "keyvault_id" {
  value = azurerm_key_vault.kv.id
}

output "keyvault_secret_username" {
  value = azurerm_key_vault_secret.vm_username.value
}

output "keyvault_secret_password" {
  value = azurerm_key_vault_secret.vm_password.value
}

output "keyvault_secret_sa_accesskey" {
  value = azurerm_key_vault_secret.sa_accesskey.value
}