resource "azurerm_key_vault" "this" {
  name                          = local.names.key_vault
  location                      = local.location
  resource_group_name           = var.resource_group_name
  tenant_id                     = var.tenant_id
  sku_name                      = "standard"
  rbac_authorization_enabled    = true
  public_network_access_enabled = false
  purge_protection_enabled      = true
  soft_delete_retention_days    = var.key_vault_soft_delete_days
  tags                          = local.tags

  network_acls {
    bypass         = "None"
    default_action = "Deny"
  }
}

resource "azurerm_key_vault_secret" "easy_auth" {
  name         = "app-service-easy-auth-client-secret"
  value        = var.entra_client_secret
  key_vault_id = azurerm_key_vault.this.id
  content_type = "Microsoft Entra application credential"

  depends_on = [time_sleep.data_plane_rbac]
}
