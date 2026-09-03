terraform {
  required_version = ">= 1.6.0, < 2.0.0"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = ">= 3.9.0, < 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.7.0, < 4.0.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">= 0.13.0, < 1.0.0"
    }
  }
}
