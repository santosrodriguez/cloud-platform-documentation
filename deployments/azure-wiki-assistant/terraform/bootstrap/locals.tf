locals {
  name_stem = "${var.name_prefix}-${var.environment}-${var.instance}"

  default_tags = {
    Application = "Azure Wiki Assistant"
    Environment = var.environment
    ManagedBy   = "Terraform"
  }

  tags = merge(local.default_tags, var.tags)

  github_federated_subjects = merge(
    var.additional_github_federated_subjects,
    {
      environment = "repo:${var.github_organization}/${var.github_repository}:environment:${var.github_environment}"
    },
  )

  target_resource_group_id = var.create_resource_group ? azurerm_resource_group.this[0].id : data.azurerm_resource_group.this[0].id
  target_location          = var.create_resource_group ? azurerm_resource_group.this[0].location : data.azurerm_resource_group.this[0].location

  network_subnet_ids = toset([
    var.app_service_integration_subnet_id,
    var.private_endpoint_subnet_id,
  ])
}
