locals {
  diagnostic_targets = {
    app      = azurerm_linux_web_app.this.id
    foundry  = azurerm_cognitive_account.foundry.id
    keyvault = azurerm_key_vault.this.id
    search   = azurerm_search_service.this.id
    storage  = azurerm_storage_account.content.id
  }
}

data "azurerm_monitor_diagnostic_categories" "this" {
  for_each = local.diagnostic_targets

  resource_id = each.value
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  for_each = local.diagnostic_targets

  name                           = "send-to-${local.names.log_analytics}"
  target_resource_id             = each.value
  log_analytics_workspace_id     = azurerm_log_analytics_workspace.this.id
  log_analytics_destination_type = "Dedicated"

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].log_category_types

    content {
      category = enabled_log.value
    }
  }

  dynamic "enabled_metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[each.key].metrics

    content {
      category = enabled_metric.value
    }
  }
}
