
data "azurerm_resource_group" "main" {
  name = var.resource_group
}

data "azurerm_storage_account" "StorageAccount" {
  name                = var.storage_account_name
  resource_group_name = data.azurerm_resource_group.main.name
}
# resource "azurerm_sql_server" "sqlserver" {
#   name                         = "${var.name == "" ? local.defaultname : var.name}sql-srvr"
#   resource_group_name          = data.azurerm_resource_group.main.name
#   location                     = data.azurerm_resource_group.main.location
#   version                      = var.server_version
#   administrator_login          = var.sql_admin_username
#   administrator_login_password = var.sql_password
#   tags                         = var.tags
# }
 resource "azurerm_mssql_database" "sqldbb" {
   name                = "${var.applicationname}sql-dbd-${var.env}"
   resource_group_name = data.azurerm_resource_group.main.name
   location            = data.azurerm_resource_group.main.location
   server_name         = var.MSSQLServerName
   extended_auditing_policy {
     storage_endpoint                        = data.azurerm_storage_account.main.primary_blob_endpoint
     storage_account_access_key              = data.azurerm_storage_account.main.primary_access_key
     storage_account_access_key_is_secondary = var.storage_account_access_key_is_secondary
     retention_in_days                       = var.retention_in_days
   }
   tags = var.tags
 }


#SQL DB Backup
resource "azurerm_mssql_database" "sqldbb" {
  name                = "${var.applicationname}sql-dbd-${var.env}"
  location            = data.azurerm_resource_group.main.location
  resource_group_name = data.azurerm_resource_group.main.name
  server_name         = var.MSSQLServerName

  threat_detection_policy {
    state                      = "Enabled"
    email_addresses            = ["dbgrl93@gmail.com"]
    retention_days             = "30"
    storage_account_access_key = "${azurerm_storage_account.StorageAccount.primary_access_key}"
    storage_endpoint           = "${azurerm_storage_account.StorageAccount.primary_blob_endpoint}"
    use_server_default         = "Enabled"
  }

  provisioner "local-exec" {
    command     = "Set-AzureRmSqlDatabaseBackupLongTermRetentionPolicy -ResourceGroupName ${azurerm_resource_group.test2.name}  -ServerName ${azurerm_sql_server.test2.name} -DatabaseName 'sqldbsrvrtf01' -WeeklyRetention P12W -YearlyRetention P5Y -WeekOfYear 16 "
    interpreter = ["PowerShell", "-Command"]
  }
    tags = var.tags
}


