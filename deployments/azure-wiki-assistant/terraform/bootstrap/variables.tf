variable "subscription_id" {
  description = "Subscription in which the application resource group and deployment identity are managed."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.subscription_id))
    error_message = "subscription_id must be an Azure subscription UUID."
  }
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.tenant_id))
    error_message = "tenant_id must be a Microsoft Entra tenant UUID."
  }
}

variable "location" {
  description = "Azure region for the resource group and managed identity."
  type        = string
}

variable "resource_group_name" {
  description = "Dedicated resource group used by the Wiki assistant platform."
  type        = string
}

variable "create_resource_group" {
  description = "Create the target resource group. Set false when it already exists."
  type        = bool
  default     = true
}

variable "name_prefix" {
  description = "Lowercase alphanumeric workload prefix, two to eight characters."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,8}$", var.name_prefix))
    error_message = "name_prefix must contain two to eight lowercase letters or numbers."
  }
}

variable "environment" {
  description = "Lowercase alphanumeric environment code, two to four characters."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{2,4}$", var.environment))
    error_message = "environment must contain two to four lowercase letters or numbers."
  }
}

variable "instance" {
  description = "Lowercase alphanumeric uniqueness suffix, three to four characters."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]{3,4}$", var.instance))
    error_message = "instance must contain three to four lowercase letters or numbers."
  }
}

variable "github_organization" {
  description = "GitHub organization that owns the deployment repository."
  type        = string

  validation {
    condition     = length(trimspace(var.github_organization)) > 0 && !strcontains(var.github_organization, "/")
    error_message = "github_organization must be a non-empty organization name without a slash."
  }
}

variable "github_repository" {
  description = "GitHub repository name authorized to use the deployment identity."
  type        = string

  validation {
    condition     = length(trimspace(var.github_repository)) > 0 && !strcontains(var.github_repository, "/")
    error_message = "github_repository must be a non-empty repository name without a slash."
  }
}

variable "github_environment" {
  description = "Protected GitHub environment authorized to deploy the platform."
  type        = string
  default     = "platform"
}

variable "additional_github_federated_subjects" {
  description = "Additional named GitHub OIDC subject claims to trust. Keep this empty unless each subject is reviewed."
  type        = map(string)
  default     = {}

  validation {
    condition     = alltrue([for name in keys(var.additional_github_federated_subjects) : can(regex("^[A-Za-z0-9-]{1,100}$", name))])
    error_message = "Each additional federated subject key must be 1-100 letters, numbers, or hyphens."
  }
}

variable "app_service_integration_subnet_id" {
  description = "Resource ID of the existing App Service VNet integration subnet."
  type        = string

  validation {
    condition     = can(regex("(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/virtualNetworks/.+/subnets/.+$", var.app_service_integration_subnet_id))
    error_message = "app_service_integration_subnet_id must be a complete Azure subnet resource ID."
  }
}

variable "private_endpoint_subnet_id" {
  description = "Resource ID of the existing private endpoint subnet."
  type        = string

  validation {
    condition     = can(regex("(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/virtualNetworks/.+/subnets/.+$", var.private_endpoint_subnet_id))
    error_message = "private_endpoint_subnet_id must be a complete Azure subnet resource ID."
  }
}

variable "manage_network_role_assignments" {
  description = "Grant Network Contributor on both existing subnets to the deployment identity."
  type        = bool
  default     = false
}

variable "private_dns_zone_ids" {
  description = "Existing centrally managed private DNS zone IDs. Used only for optional role assignments."
  type        = map(string)
  default     = {}

  validation {
    condition = alltrue([
      for id in values(var.private_dns_zone_ids) :
      can(regex("(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Network/privateDnsZones/.+$", id))
    ])
    error_message = "Every private_dns_zone_ids value must be a complete Azure Private DNS zone resource ID."
  }
}

variable "manage_private_dns_role_assignments" {
  description = "Grant Private DNS Zone Contributor on supplied zones to the deployment identity."
  type        = bool
  default     = false
}

variable "terraform_state_container_scope" {
  description = "Optional ARM resource ID of the existing Blob container used only for platform state. Grants the deployment identity data access only at that container."
  type        = string
  default     = null
  nullable    = true

  validation {
    condition = (
      var.terraform_state_container_scope == null ||
      can(regex("(?i)^/subscriptions/.+/resourceGroups/.+/providers/Microsoft.Storage/storageAccounts/.+/blobServices/default/containers/.+$", var.terraform_state_container_scope))
    )
    error_message = "terraform_state_container_scope must be null or a complete Azure Blob container ARM resource ID."
  }
}

variable "tags" {
  description = "Additional tags applied to bootstrap resources."
  type        = map(string)
  default     = {}
}
