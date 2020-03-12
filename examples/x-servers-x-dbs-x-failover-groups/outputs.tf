
output "sql_server_ids" {
  value = module.example.sql_server_ids
}

output "fqdn_sql_server" {
  value = module.example.sql_server_fqdns
}

output "database_ids" {
  value = module.example.sql_database_ids
}

output "database_secondary_locations" {
  value = module.example.sql_database_secondary_locations
}

output "firewall_rule_ids" {
  value = module.example.sql_firewall_rule_ids
}

output "mssql_elastic_pool_ids" {
  value = module.example.mssql_elastic_pool_ids
}

output "failover_group_ids" {
  value = module.example.sql_failover_group_ids
}

output "failover_group_servers" {
  value = module.example.sql_failover_group_servers
}

output "failover_group_databases" {
  value = module.example.sql_failover_group_databases
}

output "failover_group_partner_servers" {
  value = module.example.sql_failover_group_partner_servers
}

output "vnet_rule_ids" {
  value = module.example.sql_vnet_rule_ids
}

output "ad_admin_ids" {
  value = module.example.sql_ad_admin_ids
}
