variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string

  validation {
    condition     = can(regex("^[0-9a-fA-F-]{36}$", var.tenant_id))
    error_message = "tenant_id must be a Microsoft Entra tenant UUID."
  }
}

variable "application_display_name" {
  description = "Display name for the Entra application and enterprise application."
  type        = string
  default     = "Azure Wiki Assistant"
}

variable "web_app_name" {
  description = "Exact App Service app name produced by the platform stack."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,58}[a-z0-9]$", var.web_app_name))
    error_message = "web_app_name must be a valid 3-60 character App Service name."
  }
}

variable "additional_redirect_uris" {
  description = "Additional reviewed HTTPS web redirect URIs, such as an approved private custom domain callback."
  type        = set(string)
  default     = []

  validation {
    condition     = alltrue([for uri in var.additional_redirect_uris : startswith(uri, "https://")])
    error_message = "Every additional redirect URI must use HTTPS."
  }
}

variable "owner_object_ids" {
  description = "Additional Entra object IDs that own the application and service principal. The applying principal is always included."
  type        = set(string)
  default     = []

  validation {
    condition     = alltrue([for id in var.owner_object_ids : can(regex("^[0-9a-fA-F-]{36}$", id))])
    error_message = "Every owner_object_ids entry must be a Microsoft Entra object UUID."
  }
}

variable "app_role_assignments" {
  description = "Named user or group assignments. role must be Wiki.Reader, Wiki.Author, or Wiki.Administrator."
  type = map(object({
    principal_object_id = string
    role                = string
  }))
  default = {}

  validation {
    condition = alltrue([
      for assignment in values(var.app_role_assignments) :
      contains(["Wiki.Reader", "Wiki.Author", "Wiki.Administrator"], assignment.role)
    ])
    error_message = "Each assignment role must be Wiki.Reader, Wiki.Author, or Wiki.Administrator."
  }

  validation {
    condition = alltrue([
      for assignment in values(var.app_role_assignments) :
      can(regex("^[0-9a-fA-F-]{36}$", assignment.principal_object_id))
    ])
    error_message = "Each assignment principal_object_id must be a Microsoft Entra object UUID."
  }
}

variable "client_secret_validity_days" {
  description = "Initial Easy Auth client-secret lifetime. Rotation must update the platform Key Vault secret before expiry."
  type        = number
  default     = 180

  validation {
    condition     = var.client_secret_validity_days >= 30 && var.client_secret_validity_days <= 730
    error_message = "client_secret_validity_days must be between 30 and 730."
  }
}
