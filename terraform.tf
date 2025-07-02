terraform {
    required_version = ">=1.7.2"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.30.0"
        }
        random = {
            source = "hashicorp/random"
            version = "~> 3.7.0"
        }
    }
    backend "azurerm" {}
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_deleted_secrets_on_destroy = true
      recover_soft_deleted_secrets          = true
    }
  }
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
