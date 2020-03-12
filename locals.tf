locals {
  should_create_sql_databases      = var.enabled && var.sql_databases_enabled
  should_create_sql_firewall_rule  = var.enabled && var.sql_firewall_rule_enabled
  should_create_mssql_elasticpool  = var.enabled && var.mssql_elasticpool_enabled
  should_create_sql_failover_group = var.enabled && var.sql_failover_group_enabled
  should_create_sql_vnet_rule      = var.enabled && var.sql_vnet_rule_enabled
  should_create_sql_ad_admin       = var.enabled && var.sql_ad_admin_enabled
  sql_server_name                  = zipmap(var.sql_server_names, compact(concat(azurerm_sql_server.this.*.name, [""])))
  sql_server_location              = zipmap(var.sql_server_names, compact(concat(azurerm_sql_server.this.*.location, [""])))
  sql_server_id                    = zipmap(var.sql_server_names, compact(concat(azurerm_sql_server.this.*.id, [""])))
  sql_database_id                  = zipmap(var.sql_database_names, compact(concat(azurerm_sql_database.this.*.id, [""])))
}
