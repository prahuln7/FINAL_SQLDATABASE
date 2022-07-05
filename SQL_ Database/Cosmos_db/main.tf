resource  "azurerm_cosmosdb_account" "cosmosdb" {

  name                = var.cosmos_db_name
  location            = var.location
  resource_group_name = var.resource_group_name
  offer_type          = "Standard"
  kind                = "GlobalDocumentDB"

  enable_automatic_failover = true

  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 10
    max_staleness_prefix    = 200
  }

  geo_location {
    location          = var.cosmos_db_failover_location
    failover_priority = 1
  }

  geo_location {
    prefix            = var.cosmos_db_prefix
    location          = var.location
    failover_priority = 0
  }
  access_key_metadata_writes_enabled = false
  public_network_access_enabled = false
 
}
