output "resource_group_id" {
  description = "Target application resource group ID."
  value       = local.target_resource_group_id
}

output "resource_group_name" {
  description = "Target application resource group name."
  value       = var.resource_group_name
}

output "platform_deployment_identity_id" {
  description = "Resource ID of the GitHub platform deployment identity."
  value       = azurerm_user_assigned_identity.platform_deployment.id
}

output "platform_deployment_client_id" {
  description = "Client ID to store as the GitHub AZURE_CLIENT_ID environment variable."
  value       = azurerm_user_assigned_identity.platform_deployment.client_id
}

output "platform_deployment_principal_id" {
  description = "Object ID used for any separately approved network or DNS role grants."
  value       = azurerm_user_assigned_identity.platform_deployment.principal_id
}

output "github_federated_subjects" {
  description = "GitHub OIDC subjects trusted by the deployment identity."
  value       = local.github_federated_subjects
}

output "expected_web_app_name" {
  description = "Deterministic App Service name supplied to the identity stack as web_app_name."
  value       = "app-${local.name_stem}"
}

output "github_azure_environment_variables" {
  description = "Non-secret values for the protected GitHub platform environment."
  value = {
    AZURE_CLIENT_ID       = azurerm_user_assigned_identity.platform_deployment.client_id
    AZURE_SUBSCRIPTION_ID = var.subscription_id
    AZURE_TENANT_ID       = var.tenant_id
  }
}
