output "application_client_id" {
  description = "Client ID supplied to the platform stack as entra_client_id."
  value       = azuread_application.this.client_id
}

output "application_object_id" {
  description = "Object ID of the Entra application registration."
  value       = azuread_application.this.object_id
}

output "service_principal_object_id" {
  description = "Object ID of the enterprise application."
  value       = azuread_service_principal.this.object_id
}

output "application_client_secret" {
  description = "Sensitive client secret supplied to the platform stack through TF_VAR_entra_client_secret."
  value       = azuread_application_password.easy_auth.value
  sensitive   = true
}

output "application_client_secret_end_date" {
  description = "Expiry time used to schedule coordinated secret rotation."
  value       = azuread_application_password.easy_auth.end_date
}

output "app_role_ids" {
  description = "Stable role IDs emitted in Entra tokens after assignment."
  value       = local.app_role_ids
}

output "redirect_uris" {
  description = "Approved web redirect URIs configured on the application."
  value       = local.redirect_uris
}
