resource "azurerm_storage_account" "content" {
  name                              = local.names.storage
  resource_group_name               = var.resource_group_name
  location                          = local.location
  account_kind                      = "StorageV2"
  account_tier                      = "Standard"
  account_replication_type          = var.storage_replication_type
  access_tier                       = "Hot"
  https_traffic_only_enabled        = true
  min_tls_version                   = "TLS1_2"
  public_network_access_enabled     = false
  shared_access_key_enabled         = false
  default_to_oauth_authentication   = true
  allow_nested_items_to_be_public   = false
  cross_tenant_replication_enabled  = false
  infrastructure_encryption_enabled = true
  tags                              = local.tags

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = var.storage_soft_delete_days
    }

    container_delete_retention_policy {
      days = var.storage_soft_delete_days
    }
  }
}

resource "azurerm_storage_container" "content" {
  name                  = var.content_container_name
  storage_account_id    = azurerm_storage_account.content.id
  container_access_type = "private"

  depends_on = [time_sleep.data_plane_rbac]
}
