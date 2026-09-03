resource "azurerm_role_assignment" "terraform_key_vault_secrets_officer" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "terraform_search_service_contributor" {
  scope                = azurerm_search_service.this.id
  role_definition_name = "Search Service Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "terraform_search_index_data_contributor" {
  scope              = azurerm_search_service.this.id
  role_definition_id = local.role_definition_ids.search_index_data_contributor
  principal_id       = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "terraform_storage_blob_data_contributor" {
  scope                = azurerm_storage_account.content.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "runtime_foundry_user" {
  scope              = azurerm_cognitive_account.foundry.id
  role_definition_id = local.role_definition_ids.foundry_user
  principal_id       = azurerm_user_assigned_identity.runtime.principal_id
  principal_type     = "ServicePrincipal"
}

resource "azurerm_role_assignment" "runtime_search_reader" {
  scope              = azurerm_search_service.this.id
  role_definition_id = local.role_definition_ids.search_index_data_reader
  principal_id       = azurerm_user_assigned_identity.runtime.principal_id
  principal_type     = "ServicePrincipal"
}

resource "azurerm_role_assignment" "runtime_storage_reader" {
  scope                = azurerm_storage_account.content.id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = azurerm_user_assigned_identity.runtime.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "runtime_key_vault_secrets_user" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.runtime.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "runtime_monitoring_metrics_publisher" {
  scope                = azurerm_application_insights.this.id
  role_definition_name = "Monitoring Metrics Publisher"
  principal_id         = azurerm_user_assigned_identity.runtime.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "content_sync_foundry_user" {
  scope              = azurerm_cognitive_account.foundry.id
  role_definition_id = local.role_definition_ids.foundry_user
  principal_id       = azurerm_user_assigned_identity.content_sync.principal_id
  principal_type     = "ServicePrincipal"
}

resource "azurerm_role_assignment" "content_sync_search_contributor" {
  scope              = azurerm_search_service.this.id
  role_definition_id = local.role_definition_ids.search_index_data_contributor
  principal_id       = azurerm_user_assigned_identity.content_sync.principal_id
  principal_type     = "ServicePrincipal"
}

resource "azurerm_role_assignment" "content_sync_storage_contributor" {
  scope                = azurerm_storage_account.content.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.content_sync.principal_id
  principal_type       = "ServicePrincipal"
}

resource "time_sleep" "data_plane_rbac" {
  create_duration = var.role_assignment_propagation_wait

  depends_on = [
    azurerm_private_endpoint.service["key-vault"],
    azurerm_private_endpoint.service["search"],
    azurerm_private_endpoint.service["storage"],
    azurerm_role_assignment.terraform_key_vault_secrets_officer,
    azurerm_role_assignment.terraform_search_index_data_contributor,
    azurerm_role_assignment.terraform_search_service_contributor,
    azurerm_role_assignment.terraform_storage_blob_data_contributor,
  ]
}
