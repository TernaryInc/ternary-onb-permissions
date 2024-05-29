terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3"
    }

    azapi = {
      source  = "Azure/azapi"
      version = "~> 1"
    }
  }
}

data "azuread_client_config" "current" {}
