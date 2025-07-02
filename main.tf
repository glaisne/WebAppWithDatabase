resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
}


#
#   Key Vault
#


resource "random_string" "random_string" {
    length  = 5
    special = false
    upper   = false
}

resource "azurerm_key_vault" "key_vault" {
    name = "kv-webapp-${random_string.random_string.result}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    tenant_id = data.azurerm_client_config.current.tenant_id
    sku_name = "standard"
    purge_protection_enabled = false
    enable_rbac_authorization = true
}

data "azurerm_client_config" "current" {
  # This data source retrieves the current authenticated Azure client configuration
}

resource "azurerm_role_assignment" "key_vault_secret_officer" {
  scope                = resource.azurerm_key_vault.key_vault.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_secret" "kv_secret_mssql_password" {
  name         = "mssql-credentials-password"
  value        = var.mssql_credentials["password"]
  key_vault_id = azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_role_assignment.key_vault_secret_officer
  ]
}

resource "azurerm_key_vault_secret" "kv_secret_mssql_username" {
  name         = "mssql-credentials-username"
  value        = var.mssql_credentials["username"]
  key_vault_id = azurerm_key_vault.key_vault.id

  depends_on = [
    azurerm_role_assignment.key_vault_secret_officer
  ]
}


#
#   MSSql Server
#


resource "azurerm_mssql_server" "mssql" {
    name = "mssql01-bewebapp-${random_string.random_string.result}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    version = "12.0"
    administrator_login = resource.azurerm_key_vault_secret.kv_secret_mssql_username.value
    administrator_login_password = resource.azurerm_key_vault_secret.kv_secret_mssql_password.value
    minimum_tls_version = "1.2"

}

resource "azurerm_mssql_database" "mssql_db" {
    name = "db-webapp"
    server_id = azurerm_mssql_server.mssql.id
    max_size_gb = 2
    sku_name = var.mssql_sku
    collation = var.mssql_collation

    lifecycle {
        prevent_destroy = false
    }
}


#
#   Web App
#


resource "azurerm_service_plan" "service_plan" {
    name = "asp-webApp"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    os_type = "Linux"
    sku_name = "F1"

    worker_count = 1

}

resource "azurerm_linux_web_app" "app" {
    name = "as-webApp-${random_string.random_string.result}"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    service_plan_id = azurerm_service_plan.service_plan.id

    site_config {
        always_on = false
        ftps_state = "Disabled"
        default_documents = [
            "index.htm",
            "index.html"
        ]
    }
}
