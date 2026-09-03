locals {
  private_endpoint_specs = {
    foundry = {
      resource_id = azurerm_cognitive_account.foundry.id
      subresource = "account"
      private_dns_zone_ids = compact([
        lookup(var.private_dns_zone_ids, "foundry_cognitive_services", ""),
        lookup(var.private_dns_zone_ids, "foundry_openai", ""),
        lookup(var.private_dns_zone_ids, "foundry_ai_services", ""),
      ])
    }
    key-vault = {
      resource_id = azurerm_key_vault.this.id
      subresource = "vault"
      private_dns_zone_ids = compact([
        lookup(var.private_dns_zone_ids, "key_vault", ""),
      ])
    }
    monitor = {
      resource_id = azurerm_monitor_private_link_scope.this.id
      subresource = "azuremonitor"
      private_dns_zone_ids = compact([
        lookup(var.private_dns_zone_ids, "azure_monitor", ""),
        lookup(var.private_dns_zone_ids, "log_analytics_oms", ""),
        lookup(var.private_dns_zone_ids, "log_analytics_ods", ""),
        lookup(var.private_dns_zone_ids, "automation_agentsvc", ""),
        lookup(var.private_dns_zone_ids, "blob", ""),
      ])
    }
    search = {
      resource_id = azurerm_search_service.this.id
      subresource = "searchService"
      private_dns_zone_ids = compact([
        lookup(var.private_dns_zone_ids, "search", ""),
      ])
    }
    storage = {
      resource_id = azurerm_storage_account.content.id
      subresource = "blob"
      private_dns_zone_ids = compact([
        lookup(var.private_dns_zone_ids, "blob", ""),
      ])
    }
  }
}

resource "azurerm_private_endpoint" "service" {
  for_each = local.private_endpoint_specs

  name                          = "pe-${each.key}-${local.name_stem}"
  custom_network_interface_name = "nic-pe-${each.key}-${local.name_stem}"
  location                      = local.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.private_endpoint_subnet_id
  tags                          = local.tags

  private_service_connection {
    name                           = "psc-${each.key}-${local.name_stem}"
    private_connection_resource_id = each.value.resource_id
    subresource_names              = [each.value.subresource]
    is_manual_connection           = false
  }

  dynamic "private_dns_zone_group" {
    for_each = var.manage_private_dns_zone_groups ? [1] : []

    content {
      name                 = "default"
      private_dns_zone_ids = each.value.private_dns_zone_ids
    }
  }

  depends_on = [terraform_data.private_dns_contract]
}

resource "azurerm_private_endpoint" "app_service" {
  name                          = "pe-app-service-${local.name_stem}"
  custom_network_interface_name = "nic-pe-app-service-${local.name_stem}"
  location                      = local.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.private_endpoint_subnet_id
  tags                          = local.tags

  private_service_connection {
    name                           = "psc-app-service-${local.name_stem}"
    private_connection_resource_id = azurerm_linux_web_app.this.id
    subresource_names              = ["sites"]
    is_manual_connection           = false
  }

  dynamic "private_dns_zone_group" {
    for_each = var.manage_private_dns_zone_groups ? [1] : []

    content {
      name = "default"
      private_dns_zone_ids = compact([
        lookup(var.private_dns_zone_ids, "app_service", ""),
      ])
    }
  }

  depends_on = [terraform_data.private_dns_contract]
}
