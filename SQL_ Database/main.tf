terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.12.0"
    }
  }
}

provider "azurerm" {
  features {}
}

module "MSSQLServer" {
  source = "./MSSQLServer"
}

module "Log_Analytics_Workspace" {
  source           = "./Log_Analytics_Workspace"
}

module "MSSQLDatabase" {
  source           = "./SQL_Database"
  MSSQLServerName  = module.MSSQLServer.mssql_server_name
}

module "PrivateEndPoint" {
 source = "./Private_Endpoint"
 private_connection_resource_id = module.MSSQLServer.MSSQLServer_ResourceID
 azurerm_mssql_server = module.MSSQLDatabase.azurermmssqlserver
}
module "SQL Managed Instance" {
  source           = "./SQL Managed Instance"
  MSSQLServerName  = module.SQL_Managed_Instance_name
}
module "Route_table_module" {
  source           = "./Route_table_module"
}
module "SubNet_module" {
  source           = "./SubNet_module"
}
module "azurerm_subnet_route_table_association_module" {
  source           = "./azurerm_subnet_route_table_association_module"
}
module "VNet_module" {
  source           = "./VNet_module"
}
module "Cosmos_db" {
  source           = "./Cosmos_db"
}
module "Cosmos_db_database" {
  source           = "./Cosmos_db_database"
}