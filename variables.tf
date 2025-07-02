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
    default = "rg-terraform_project03"
}

variable "location" {
    type = string
    description = "Location (or region) for the Azure resources"
    default = "eastus2"
}


#
#   SQL Variables
#


variable "mssql_credentials" {
    type = map
    description = "Credentials for mssql server"
}

variable "mssql_sku" {
    type = string
    description = "SKU used for MSSQL managed service"
    default = "Basic"
}

variable "mssql_collation" {
    type = string
    description = "Collation configuration used for MSSQL managed service"
    default = "SQL_Latin1_General_CP1_CI_AS"
}