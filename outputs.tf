###
# SQL server
###

output "sql_server_ids" {
  description = "IDs of the SQL servers."
  value       = compact(concat(azurerm_sql_server.this.*.id, [""]))
}

output "sql_server_fqdn" {
  description = "The fully qualified domain names of the SQL servers."
  value       = compact(concat(azurerm_sql_server.this.*.fully_qualified_domain_name, [""]))
}

###
# SQL database
###

output "sql_database_ids" {
  description = "The IDs of the SQL databases."
  value       = compact(concat(azurerm_sql_database.this.*.id, [""]))
}

output "sql_database_creation_date" {
  description = "The dates at which SQL database was created."
  value       = compact(concat(azurerm_sql_database.this.*.creation_date, [""]))
}

output "sql_database_secondary_location" {
  description = "The default secondary location of the SQL databases."
  value       = compact(concat(azurerm_sql_database.this.*.default_secondary_location, [""]))
}

###
# SQL firewall rule
###

output "sql_firewall_rule_ids" {
  description = "The IDs of the SQL firewall rules."
  value       = compact(concat(azurerm_sql_firewall_rule.this.*.id, [""]))
}

###
# MSSQL elastic pool
###

output "mssql_elatic_pool_ids" {
  description = "The IDs of the MS SQL elastic pools."
  value       = compact(concat(azurerm_mssql_elasticpool.this.*.id, [""]))
}

###
# SQL failover group
###

output "sql_failover_group_ids" {
  description = "The IDs of the failover groups."
  value       = compact(concat(azurerm_sql_failover_group.this.*.id, [""]))
}

output "sql_failover_group_locations" {
  description = "The locations of the failover group"
  value       = compact(concat(azurerm_sql_failover_group.this.*.location, [""]))
}

output "sql_failover_group_servers" {
  description = "The names of the primary SQL database server."
  value       = compact(concat(azurerm_sql_failover_group.this.*.server_name, [""]))
}

output "sql_failover_group_role" {
  description = "The local replication roles of the failover group instances."
  value       = compact(concat(azurerm_sql_failover_group.this.*.role, [""]))
}

output "sql_failover_group_databases" {
  description = "The list of databases in the failover group."
  value       = azurerm_sql_failover_group.this.*.databases
}

output "sql_failover_group_partner_servers" {
  description = "The list of partner server information for the failover group."
  value       = azurerm_sql_failover_group.this.*.partner_servers
}

###
# SQL vnet rule
###

output "sql_vnet_rule_ids" {
  description = "The IDs of the SQL virtual network rules."
  value       = compact(concat(azurerm_sql_virtual_network_rule.this_vnet_rule.*.id, [""]))
}

###
# SQL AD administrator
###

output "sql_ad_admins_ids" {
  description = "The IDs od the SQL AD administratot."
  value       = compact(concat(azurerm_sql_active_directory_administrator.this.*.id, [""]))
}
