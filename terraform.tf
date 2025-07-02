terraform {
    required_version = ">=1.7.2"

    required_providers {
        azurerm = {
            source = "hashicorp/azurerm"
            version = "~> 4.30.0"
        }
    }
    backend "azurerm" {}
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
}
