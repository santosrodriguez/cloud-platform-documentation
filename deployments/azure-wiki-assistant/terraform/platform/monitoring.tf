resource "azurerm_log_analytics_workspace" "this" {
  name                           = local.names.log_analytics
  location                       = local.location
  resource_group_name            = var.resource_group_name
  sku                            = "PerGB2018"
  retention_in_days              = var.log_retention_in_days
  local_authentication_enabled   = false
  internet_ingestion_access_type = "Disabled"
  internet_query_access_type     = "Disabled"
  tags                           = local.tags
}

resource "azurerm_application_insights" "this" {
  name                         = local.names.application_insights
  location                     = local.location
  resource_group_name          = var.resource_group_name
  application_type             = "web"
  workspace_id                 = azurerm_log_analytics_workspace.this.id
  local_authentication_enabled = false
  internet_ingestion_enabled   = false
  internet_query_enabled       = false
  tags                         = local.tags
}

resource "azurerm_monitor_private_link_scope" "this" {
  name                  = local.names.azure_monitor_private_link_scope
  resource_group_name   = var.resource_group_name
  ingestion_access_mode = "PrivateOnly"
  query_access_mode     = "PrivateOnly"
  tags                  = local.tags
}

resource "azurerm_monitor_private_link_scoped_service" "log_analytics" {
  name                = "ampls-${local.name_stem}-logs"
  resource_group_name = var.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.this.name
  linked_resource_id  = azurerm_log_analytics_workspace.this.id
}

resource "azurerm_monitor_private_link_scoped_service" "application_insights" {
  name                = "ampls-${local.name_stem}-appi"
  resource_group_name = var.resource_group_name
  scope_name          = azurerm_monitor_private_link_scope.this.name
  linked_resource_id  = azurerm_application_insights.this.id
}
