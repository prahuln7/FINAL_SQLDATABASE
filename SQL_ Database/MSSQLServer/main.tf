
data "azurerm_resource_group" "main" {
  name = var.resource_group
}
resource "azurerm_mssql_server" "mssql" {
	# checkov:skip=BC_AZR_LOGGING_3: ADD REASON

  name                         = var.azurerm_mssql_server
  resource_group_name          = data.azurerm_resource_group.main.name
  location                     = data.azurerm_resource_group.main.location
  version                      = var.server_version
  administrator_login          = var.mssql_admin_username
  administrator_login_password = var.mssql_password
  minimum_tls_version          = var.minimum_tls_version
  tags                         = var.tags
  
   public_network_access_enabled = false
}


   public_network_access_enabled = false



 resource "azurerm_mssql_server_transparent_data_encryption" "example" {
   server_id        = azurerm_mssql_server.example.id
   key_vault_key_id = azurerm_key_vault_key.example.id
}
extended_auditing_policy {
       storage_endpoint           = azurerm_storage_account.example.primary_blob_endpoint
       storage_account_access_key = azurerm_storage_account.example.primary_access_key
       storage_account_access_key_is_secondary = true
       retention_in_days                       = 90
    }
{}
