data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "terraform_data" "private_dns_contract" {
  input = var.private_dns_zone_ids

  lifecycle {
    precondition {
      condition = !var.manage_private_dns_zone_groups || length(setsubtract(
        local.required_private_dns_zone_keys,
        toset(keys(var.private_dns_zone_ids)),
      )) == 0
      error_message = "private_dns_zone_ids must contain every documented key when manage_private_dns_zone_groups is true."
    }
  }
}
