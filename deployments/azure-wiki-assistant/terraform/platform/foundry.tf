resource "azurerm_cognitive_account" "foundry" {
  name                          = local.names.foundry
  location                      = local.location
  resource_group_name           = var.resource_group_name
  kind                          = "AIServices"
  sku_name                      = "S0"
  custom_subdomain_name         = local.names.foundry
  project_management_enabled    = true
  local_auth_enabled            = false
  public_network_access_enabled = false
  tags                          = local.tags

  identity {
    type = "SystemAssigned"
  }

  network_acls {
    default_action = "Deny"
    bypass         = "None"
  }
}

resource "azurerm_cognitive_account_project" "this" {
  name                 = local.names.foundry_project
  cognitive_account_id = azurerm_cognitive_account.foundry.id
  location             = local.location
  display_name         = "Azure Wiki Assistant"
  description          = "Private Microsoft Foundry project for grounded Cloud Platform Wiki assistance."
  tags                 = local.tags

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_cognitive_deployment" "chat" {
  name                 = var.chat_model.deployment_name
  cognitive_account_id = azurerm_cognitive_account.foundry.id

  model {
    format  = "OpenAI"
    name    = var.chat_model.model_name
    version = var.chat_model.model_version
  }

  sku {
    name     = var.chat_model.sku_name
    capacity = var.chat_model.capacity
  }
}

resource "azurerm_cognitive_deployment" "embedding" {
  name                 = var.embedding_model.deployment_name
  cognitive_account_id = azurerm_cognitive_account.foundry.id

  model {
    format  = "OpenAI"
    name    = var.embedding_model.model_name
    version = var.embedding_model.model_version
  }

  sku {
    name     = var.embedding_model.sku_name
    capacity = var.embedding_model.capacity
  }
}
