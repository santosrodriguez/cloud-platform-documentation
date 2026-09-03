data "azuread_client_config" "current" {}

resource "random_uuid" "reader" {}

resource "random_uuid" "author" {}

resource "random_uuid" "administrator" {}

resource "time_static" "client_secret_created" {}

resource "azuread_application" "this" {
  display_name            = var.application_display_name
  description             = "Single-tenant authentication and application roles for the private Azure Wiki Assistant."
  sign_in_audience        = "AzureADMyOrg"
  prevent_duplicate_names = true
  group_membership_claims = ["SecurityGroup"]
  owners                  = local.owners

  app_role {
    allowed_member_types = ["User"]
    description          = "Can sign in and query approved Wiki content."
    display_name         = "Wiki Reader"
    enabled              = true
    id                   = random_uuid.reader.result
    value                = "Wiki.Reader"
  }

  app_role {
    allowed_member_types = ["User"]
    description          = "Can perform approved content-authoring operations exposed by the application."
    display_name         = "Wiki Author"
    enabled              = true
    id                   = random_uuid.author.result
    value                = "Wiki.Author"
  }

  app_role {
    allowed_member_types = ["User"]
    description          = "Can perform approved administrative operations exposed by the application."
    display_name         = "Wiki Administrator"
    enabled              = true
    id                   = random_uuid.administrator.result
    value                = "Wiki.Administrator"
  }

  web {
    homepage_url  = local.web_app_url
    logout_url    = "${local.web_app_url}/.auth/logout"
    redirect_uris = local.redirect_uris

    implicit_grant {
      access_token_issuance_enabled = false
      id_token_issuance_enabled     = false
    }
  }
}

resource "azuread_service_principal" "this" {
  client_id                    = azuread_application.this.client_id
  app_role_assignment_required = true
  owners                       = local.owners
}

resource "azuread_application_password" "easy_auth" {
  application_id = azuread_application.this.id
  display_name   = "App Service Easy Auth"
  start_date     = time_static.client_secret_created.rfc3339
  end_date       = timeadd(time_static.client_secret_created.rfc3339, format("%dh", var.client_secret_validity_days * 24))
}

resource "azuread_app_role_assignment" "this" {
  for_each = var.app_role_assignments

  app_role_id         = local.app_role_ids[each.value.role]
  principal_object_id = each.value.principal_object_id
  resource_object_id  = azuread_service_principal.this.object_id
}
