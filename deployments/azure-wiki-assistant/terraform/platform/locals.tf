locals {
  name_stem    = "${var.name_prefix}-${var.environment}-${var.instance}"
  compact_stem = "${var.name_prefix}${var.environment}${var.instance}"
  location     = data.azurerm_resource_group.this.location

  names = {
    app_service_plan                 = "asp-${local.name_stem}"
    app                              = "app-${local.name_stem}"
    app_deployment                   = "id-${local.name_stem}-appdeploy"
    application_insights             = "appi-${local.name_stem}"
    azure_monitor_private_link_scope = "ampls-${local.name_stem}"
    content_sync                     = "id-${local.name_stem}-contentsync"
    foundry                          = "aif-${local.name_stem}"
    foundry_project                  = "project-${local.name_stem}"
    key_vault                        = "kv-${local.name_stem}"
    log_analytics                    = "log-${local.name_stem}"
    runtime                          = "id-${local.name_stem}-runtime"
    search                           = "srch-${local.name_stem}"
    storage                          = "st${local.compact_stem}"
  }

  default_tags = {
    Application = "Azure Wiki Assistant"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  tags = merge(local.default_tags, var.tags)

  required_private_dns_zone_keys = toset([
    "app_service",
    "automation_agentsvc",
    "azure_monitor",
    "blob",
    "foundry_ai_services",
    "foundry_cognitive_services",
    "foundry_openai",
    "key_vault",
    "log_analytics_ods",
    "log_analytics_oms",
    "search",
  ])

  subscription_scope = "/subscriptions/${var.subscription_id}"
  role_definition_ids = {
    foundry_user                  = "${local.subscription_scope}/providers/Microsoft.Authorization/roleDefinitions/53ca6127-db72-4b80-b1b0-d745d6d5456d"
    search_index_data_contributor = "${local.subscription_scope}/providers/Microsoft.Authorization/roleDefinitions/8ebe5a00-799e-43f5-93ac-243d3dce84a7"
    search_index_data_reader      = "${local.subscription_scope}/providers/Microsoft.Authorization/roleDefinitions/1407120a-92aa-4202-b7e9-c0e197c71c8f"
  }

  required_app_settings = {
    APPLICATIONINSIGHTS_CONNECTION_STRING      = azurerm_application_insights.this.connection_string
    APPLICATIONINSIGHTS_AUTHENTICATION_STRING  = "Authorization=AAD;ClientId=${azurerm_user_assigned_identity.runtime.client_id}"
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3"
    AZURE_CLIENT_ID                            = azurerm_user_assigned_identity.runtime.client_id
    AZURE_TENANT_ID                            = var.tenant_id
    AZURE_AI_FOUNDRY_ENDPOINT                  = azurerm_cognitive_account.foundry.endpoint
    AZURE_AI_CHAT_DEPLOYMENT                   = azurerm_cognitive_deployment.chat.name
    AZURE_AI_EMBEDDING_DEPLOYMENT              = azurerm_cognitive_deployment.embedding.name
    AZURE_AI_SEARCH_ENDPOINT                   = "https://${azurerm_search_service.this.name}.search.windows.net"
    AZURE_AI_SEARCH_INDEX                      = var.search_index_name
    AZURE_STORAGE_BLOB_ENDPOINT                = azurerm_storage_account.content.primary_blob_endpoint
    AZURE_STORAGE_CONTENT_CONTAINER            = var.content_container_name
    MICROSOFT_PROVIDER_AUTHENTICATION_SECRET   = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.easy_auth.versionless_id})"
    SCM_DO_BUILD_DURING_DEPLOYMENT             = "true"
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES        = "10"
  }

  app_settings = merge(var.additional_app_settings, local.required_app_settings)
}
