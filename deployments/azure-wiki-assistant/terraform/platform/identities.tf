resource "azurerm_user_assigned_identity" "runtime" {
  name                = local.names.runtime
  location            = local.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_user_assigned_identity" "app_deployment" {
  name                = local.names.app_deployment
  location            = local.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_user_assigned_identity" "content_sync" {
  name                = local.names.content_sync
  location            = local.location
  resource_group_name = var.resource_group_name
  tags                = local.tags
}

resource "azurerm_federated_identity_credential" "app_deployment" {
  name                      = "github-app-deployment"
  user_assigned_identity_id = azurerm_user_assigned_identity.app_deployment.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:${var.github_organization}/${var.github_repository}:environment:${var.app_deployment_github_environment}"
}

resource "azurerm_federated_identity_credential" "content_sync" {
  name                      = "github-content-sync"
  user_assigned_identity_id = azurerm_user_assigned_identity.content_sync.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = "repo:${var.github_organization}/${var.github_repository}:environment:${var.content_sync_github_environment}"
}
