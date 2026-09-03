variable "subscription_id" {
  description = "Subscription containing the Wiki assistant resource group."
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

variable "resource_group_name" {
  description = "Existing dedicated resource group created or selected by the bootstrap stack."
  type        = string
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

variable "app_service_integration_subnet_id" {
  description = "Resource ID of the existing delegated App Service VNet integration subnet."
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

variable "manage_private_dns_zone_groups" {
  description = "Associate private endpoints with existing centrally managed private DNS zones."
  type        = bool
  default     = true
}

variable "private_dns_zone_ids" {
  description = "Map of documented private DNS keys to existing central zone resource IDs."
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

variable "entra_client_id" {
  description = "Application client ID returned by the identity stack."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.entra_client_id))
    error_message = "entra_client_id must be a Microsoft Entra application UUID."
  }
}

variable "entra_client_secret" {
  description = "Easy Auth secret returned by the identity stack. Supply only through TF_VAR_entra_client_secret."
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.entra_client_secret) >= 16
    error_message = "entra_client_secret does not appear to contain a valid secret value."
  }
}

variable "github_organization" {
  description = "GitHub organization that owns the application repository."
  type        = string

  validation {
    condition     = length(trimspace(var.github_organization)) > 0 && !strcontains(var.github_organization, "/")
    error_message = "github_organization must be a non-empty organization name without a slash."
  }
}

variable "github_repository" {
  description = "GitHub application repository trusted by workload identity federation."
  type        = string

  validation {
    condition     = length(trimspace(var.github_repository)) > 0 && !strcontains(var.github_repository, "/")
    error_message = "github_repository must be a non-empty repository name without a slash."
  }
}

variable "app_deployment_github_environment" {
  description = "Protected GitHub environment allowed to deploy application code."
  type        = string
  default     = "app-deployment"
}

variable "content_sync_github_environment" {
  description = "Protected GitHub environment allowed to synchronize Wiki content."
  type        = string
  default     = "content-sync"
}

variable "app_service_sku_name" {
  description = "Linux App Service plan SKU. Use a production-capable SKU that supports VNet integration."
  type        = string
  default     = "P1v3"
}

variable "app_runtime" {
  description = "Exactly one supported App Service language runtime. Application code is deployed separately."
  type = object({
    dotnet_version = optional(string)
    node_version   = optional(string)
    python_version = optional(string)
  })

  validation {
    condition = length(compact([
      try(var.app_runtime.dotnet_version, ""),
      try(var.app_runtime.node_version, ""),
      try(var.app_runtime.python_version, ""),
    ])) == 1
    error_message = "Set exactly one of app_runtime.dotnet_version, node_version, or python_version."
  }
}

variable "app_startup_command" {
  description = "Optional App Service startup command required by the selected application framework."
  type        = string
  default     = null
  nullable    = true
}

variable "health_check_path" {
  description = "Anonymous application health endpoint used by App Service."
  type        = string
  default     = "/health"

  validation {
    condition     = startswith(var.health_check_path, "/")
    error_message = "health_check_path must begin with a slash."
  }
}

variable "additional_app_settings" {
  description = "Non-secret application settings. Required security and service settings cannot be overridden."
  type        = map(string)
  default     = {}
}

variable "search_sku" {
  description = "Azure AI Search SKU."
  type        = string
  default     = "standard"
}

variable "search_replica_count" {
  description = "Azure AI Search replica count."
  type        = number
  default     = 1

  validation {
    condition     = contains([1, 2, 3, 4, 6, 12], var.search_replica_count)
    error_message = "search_replica_count must be 1, 2, 3, 4, 6, or 12."
  }
}

variable "search_partition_count" {
  description = "Azure AI Search partition count."
  type        = number
  default     = 1

  validation {
    condition     = contains([1, 2, 3, 4, 6, 12], var.search_partition_count)
    error_message = "search_partition_count must be 1, 2, 3, 4, 6, or 12."
  }
}

variable "enable_semantic_search" {
  description = "Add semantic ranking configuration to the Wiki search index."
  type        = bool
  default     = true
}

variable "semantic_search_sku" {
  description = "Semantic Search SKU used when semantic search is enabled."
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["free", "standard"], var.semantic_search_sku)
    error_message = "semantic_search_sku must be free or standard."
  }
}

variable "search_index_name" {
  description = "Name of the hybrid vector search index."
  type        = string
  default     = "wiki-content"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9_-]{1,126}[a-z0-9]$", var.search_index_name))
    error_message = "search_index_name must be 3-128 lowercase letters, numbers, underscores, or hyphens."
  }
}

variable "create_search_index" {
  description = "Create the data-plane Search index. Requires private network access from the Terraform runner."
  type        = bool
  default     = true
}

variable "chat_model" {
  description = "Approved regional chat model deployment. Values are intentionally explicit."
  type = object({
    deployment_name = string
    model_name      = string
    model_version   = string
    sku_name        = string
    capacity        = number
  })

  validation {
    condition     = var.chat_model.capacity > 0 && floor(var.chat_model.capacity) == var.chat_model.capacity
    error_message = "chat_model.capacity must be a positive whole number."
  }
}

variable "embedding_model" {
  description = "Approved regional embedding model deployment. Values are intentionally explicit."
  type = object({
    deployment_name = string
    model_name      = string
    model_version   = string
    sku_name        = string
    capacity        = number
  })

  validation {
    condition     = var.embedding_model.capacity > 0 && floor(var.embedding_model.capacity) == var.embedding_model.capacity
    error_message = "embedding_model.capacity must be a positive whole number."
  }
}

variable "embedding_dimensions" {
  description = "Vector dimensions emitted by the selected embedding model."
  type        = number

  validation {
    condition     = var.embedding_dimensions > 0 && floor(var.embedding_dimensions) == var.embedding_dimensions
    error_message = "embedding_dimensions must be a positive whole number matching the approved model."
  }
}

variable "storage_replication_type" {
  description = "Storage replication selected for regional resiliency requirements."
  type        = string
  default     = "ZRS"

  validation {
    condition     = contains(["LRS", "GRS", "RAGRS", "ZRS", "GZRS", "RAGZRS"], var.storage_replication_type)
    error_message = "storage_replication_type must be LRS, GRS, RAGRS, ZRS, GZRS, or RAGZRS."
  }
}

variable "content_container_name" {
  description = "Private Blob container used for normalized Wiki content."
  type        = string
  default     = "wiki-content"

  validation {
    condition = (
      length(var.content_container_name) >= 3 &&
      length(var.content_container_name) <= 63 &&
      can(regex("^[a-z0-9]+(-[a-z0-9]+)*$", var.content_container_name))
    )
    error_message = "content_container_name must be 3-63 lowercase letters, numbers, or single hyphens."
  }
}

variable "storage_soft_delete_days" {
  description = "Blob and container soft-delete retention."
  type        = number
  default     = 30

  validation {
    condition     = var.storage_soft_delete_days >= 1 && var.storage_soft_delete_days <= 365
    error_message = "storage_soft_delete_days must be between 1 and 365."
  }
}

variable "key_vault_soft_delete_days" {
  description = "Key Vault soft-delete retention. Purge protection is always enabled."
  type        = number
  default     = 90

  validation {
    condition     = var.key_vault_soft_delete_days >= 7 && var.key_vault_soft_delete_days <= 90
    error_message = "key_vault_soft_delete_days must be between 7 and 90."
  }
}

variable "log_retention_in_days" {
  description = "Log Analytics retention period."
  type        = number
  default     = 30

  validation {
    condition     = var.log_retention_in_days >= 30 && var.log_retention_in_days <= 730
    error_message = "log_retention_in_days must be between 30 and 730."
  }
}

variable "role_assignment_propagation_wait" {
  description = "Wait before creating private data-plane resources after RBAC changes."
  type        = string
  default     = "60s"

  validation {
    condition     = can(regex("^[1-9][0-9]*s$", var.role_assignment_propagation_wait))
    error_message = "role_assignment_propagation_wait must be a positive duration in seconds, such as 60s."
  }
}

variable "tags" {
  description = "Additional tags applied to platform resources."
  type        = map(string)
  default     = {}
}
