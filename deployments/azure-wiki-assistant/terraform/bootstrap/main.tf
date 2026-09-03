resource "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 1 : 0

  name     = var.resource_group_name
  location = var.location
  tags     = local.tags
}

data "azurerm_resource_group" "this" {
  count = var.create_resource_group ? 0 : 1

  name = var.resource_group_name
}

resource "azurerm_user_assigned_identity" "platform_deployment" {
  name                = "id-${local.name_stem}-platform"
  location            = local.target_location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  depends_on = [azurerm_resource_group.this]
}

resource "azurerm_federated_identity_credential" "github" {
  for_each = local.github_federated_subjects

  name                      = "github-${each.key}"
  user_assigned_identity_id = azurerm_user_assigned_identity.platform_deployment.id
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = "https://token.actions.githubusercontent.com"
  subject                   = each.value
}

resource "azurerm_role_assignment" "resource_group_contributor" {
  scope                = local.target_resource_group_id
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.platform_deployment.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "resource_group_rbac_administrator" {
  scope                = local.target_resource_group_id
  role_definition_name = "Role Based Access Control Administrator"
  principal_id         = azurerm_user_assigned_identity.platform_deployment.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "network_contributor" {
  for_each = var.manage_network_role_assignments ? local.network_subnet_ids : toset([])

  scope                = each.value
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.platform_deployment.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "private_dns_zone_contributor" {
  for_each = var.manage_private_dns_role_assignments ? var.private_dns_zone_ids : {}

  scope                = each.value
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.platform_deployment.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "terraform_state_blob_data_contributor" {
  count = var.terraform_state_container_scope == null ? 0 : 1

  scope                = var.terraform_state_container_scope
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_user_assigned_identity.platform_deployment.principal_id
  principal_type       = "ServicePrincipal"
}
