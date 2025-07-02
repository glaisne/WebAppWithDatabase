variable "tenant_id" {
    type = string
    description = "Tenant ID"
}

variable "subscription_id" {
    type = string
    description = "Subscription ID"
}

variable "resource_group_name" {
    type = string
    description = "Name of the Resource Group Name"
    default = "rg-terraform_project"
}

variable "location" {
    type = string
    description = "Location (or region) for the Azure resources"
    default = "eastus2"
}