resource "azurerm_service_plan" "this" {
  name                = local.names.app_service_plan
  resource_group_name = var.resource_group_name
  location            = local.location
  os_type             = "Linux"
  sku_name            = var.app_service_sku_name
  worker_count        = 1
  tags                = local.tags
}

resource "azurerm_linux_web_app" "this" {
  name                                           = local.names.app
  resource_group_name                            = var.resource_group_name
  location                                       = local.location
  service_plan_id                                = azurerm_service_plan.this.id
  virtual_network_subnet_id                      = var.app_service_integration_subnet_id
  public_network_access_enabled                  = false
  https_only                                     = true
  client_affinity_enabled                        = false
  ftp_publish_basic_authentication_enabled       = false
  webdeploy_publish_basic_authentication_enabled = false
  key_vault_reference_identity_id                = azurerm_user_assigned_identity.runtime.id
  app_settings                                   = local.app_settings
  tags                                           = local.tags

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.runtime.id]
  }

  site_config {
    always_on                         = true
    app_command_line                  = var.app_startup_command
    ftps_state                        = "Disabled"
    health_check_path                 = var.health_check_path
    health_check_eviction_time_in_min = 5
    http2_enabled                     = true
    minimum_tls_version               = "1.2"
    scm_minimum_tls_version           = "1.2"
    use_32_bit_worker                 = false
    vnet_route_all_enabled            = true
    websockets_enabled                = false

    application_stack {
      dotnet_version = try(var.app_runtime.dotnet_version, null)
      node_version   = try(var.app_runtime.node_version, null)
      python_version = try(var.app_runtime.python_version, null)
    }
  }

  auth_settings_v2 {
    auth_enabled           = true
    require_authentication = true
    unauthenticated_action = "RedirectToLoginPage"
    default_provider       = "azureactivedirectory"
    excluded_paths         = [var.health_check_path]

    active_directory_v2 {
      client_id                  = var.entra_client_id
      tenant_auth_endpoint       = "https://login.microsoftonline.com/${var.tenant_id}/v2.0/"
      client_secret_setting_name = "MICROSOFT_PROVIDER_AUTHENTICATION_SECRET"
      allowed_audiences = [
        var.entra_client_id,
        "api://${var.entra_client_id}",
      ]
    }

    login {
      token_store_enabled = false
    }
  }

  depends_on = [
    azurerm_key_vault_secret.easy_auth,
    azurerm_role_assignment.runtime_key_vault_secrets_user,
    azurerm_role_assignment.runtime_monitoring_metrics_publisher,
  ]
}

resource "azurerm_role_assignment" "app_deployment_website_contributor" {
  scope                = azurerm_linux_web_app.this.id
  role_definition_name = "Website Contributor"
  principal_id         = azurerm_user_assigned_identity.app_deployment.principal_id
  principal_type       = "ServicePrincipal"
}
