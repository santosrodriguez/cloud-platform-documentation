output "resource_group_id" {
  description = "Resource group containing the private application platform."
  value       = data.azurerm_resource_group.this.id
}

output "web_app" {
  description = "Private App Service identifiers. The URL resolves privately when central DNS is complete."
  value = {
    id       = azurerm_linux_web_app.this.id
    name     = azurerm_linux_web_app.this.name
    hostname = azurerm_linux_web_app.this.default_hostname
    url      = "https://${azurerm_linux_web_app.this.default_hostname}"
  }
}

output "foundry" {
  description = "Microsoft Foundry resource and project details."
  value = {
    account_id           = azurerm_cognitive_account.foundry.id
    account_name         = azurerm_cognitive_account.foundry.name
    account_endpoint     = azurerm_cognitive_account.foundry.endpoint
    project_id           = azurerm_cognitive_account_project.this.id
    project_name         = azurerm_cognitive_account_project.this.name
    project_endpoints    = azurerm_cognitive_account_project.this.endpoints
    chat_deployment      = azurerm_cognitive_deployment.chat.name
    embedding_deployment = azurerm_cognitive_deployment.embedding.name
  }
}

output "search" {
  description = "Private Azure AI Search endpoint and index."
  value = {
    id                         = azurerm_search_service.this.id
    name                       = azurerm_search_service.this.name
    endpoint                   = "https://${azurerm_search_service.this.name}.search.windows.net"
    index_name                 = var.search_index_name
    index_managed_by_terraform = var.create_search_index
  }
}

output "content_storage" {
  description = "Private Wiki content storage details."
  value = {
    account_id    = azurerm_storage_account.content.id
    account_name  = azurerm_storage_account.content.name
    blob_endpoint = azurerm_storage_account.content.primary_blob_endpoint
    container     = azurerm_storage_container.content.name
  }
}

output "key_vault" {
  description = "Private Key Vault details. No secret values are returned."
  value = {
    id   = azurerm_key_vault.this.id
    name = azurerm_key_vault.this.name
    uri  = azurerm_key_vault.this.vault_uri
  }
}

output "monitoring" {
  description = "Private Azure-native monitoring resources used alongside the organization's Dynatrace standard."
  value = {
    log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
    application_insights_id    = azurerm_application_insights.this.id
    private_link_scope_id      = azurerm_monitor_private_link_scope.this.id
  }
}

output "workload_identities" {
  description = "Client and object IDs used in GitHub environments and application configuration."
  value = {
    runtime = {
      client_id    = azurerm_user_assigned_identity.runtime.client_id
      principal_id = azurerm_user_assigned_identity.runtime.principal_id
    }
    app_deployment = {
      client_id    = azurerm_user_assigned_identity.app_deployment.client_id
      principal_id = azurerm_user_assigned_identity.app_deployment.principal_id
    }
    content_sync = {
      client_id    = azurerm_user_assigned_identity.content_sync.client_id
      principal_id = azurerm_user_assigned_identity.content_sync.principal_id
    }
  }
}

output "private_endpoint_dns" {
  description = "Private endpoint IP and FQDN data for central DNS validation or manual registration."
  value = merge(
    {
      for name, endpoint in azurerm_private_endpoint.service : name => {
        private_ip_address = endpoint.private_service_connection[0].private_ip_address
        custom_dns_configs = endpoint.custom_dns_configs
      }
    },
    {
      app-service = {
        private_ip_address = azurerm_private_endpoint.app_service.private_service_connection[0].private_ip_address
        custom_dns_configs = azurerm_private_endpoint.app_service.custom_dns_configs
      }
    },
  )
}
