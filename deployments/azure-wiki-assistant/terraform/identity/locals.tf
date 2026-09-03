locals {
  web_app_url = "https://${var.web_app_name}.azurewebsites.net"
  redirect_uris = setunion(
    toset(["${local.web_app_url}/.auth/login/aad/callback"]),
    var.additional_redirect_uris,
  )

  owners = setunion(
    toset([data.azuread_client_config.current.object_id]),
    var.owner_object_ids,
  )

  app_role_ids = {
    "Wiki.Reader"        = random_uuid.reader.result
    "Wiki.Author"        = random_uuid.author.result
    "Wiki.Administrator" = random_uuid.administrator.result
  }
}
