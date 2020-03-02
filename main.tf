locals {

}


###
# SQL server
###

resource "azurerm_sql_server" "this" {
  count = var.enabled ? 1 : 0

  name                         = var.sql_server_names
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = var.sql_server_versions
  administrator_login          = var.sql_server_administrator_login
  administrator_login_password = var.sql_server_administrator_login_password

  dynamic "identity" {
    for_each = element(var.identity_type, count.index) != "" ? [1] : []

    content {
      type = var.identity_type
    }
  }

  tags = merge(
    var.tags,
    var.sql_server_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# SQL database
###

resource "azurerm_sql_database" "this_database" {
  count = var.enabled ? 1 : 0

  name                             = var.sql_database_names
  resource_group_name              = var.resource_group_name
  location                         = var.location
  server_name                      = azurerm_sql_server.this[count.index].name
  source_database_id               = var.sql_source_database_ids
  restore_point_in_time            = var.sql_database_restore_point_in_time
  edition                          = var.sql_database_editions
  collation                        = var.sql_database_collation
  max_size_bytes                   = var.sql_database_max_size_bytes
  requested_service_objective_id   = var.sql_database_requested_service_objective_id
  requested_service_objective_name = var.sql_database_requested_service_objective_name
  source_database_deletion_date    = var.sql_source_database_deletion_date
  elastic_pool_name                = var.sql_database_elastic_pool_names
  read_scale                       = var.sql_database_read_scale
  zone_redundant                   = var.sql_database_zone_redundant


  dynamic "import" {
    for_each = var.import_storage_uri[count.index] != "" ? [1] : []

    content {
      storage_uri                  = var.import_storage_uri
      storage_key                  = var.import_storage_key
      storage_key_type             = var.import_storage_key_type
      administrator_login          = var.import_administrator_login
      administrator_login_password = var.import_administrator_login_password
      authentication_type          = var.import_authentication_type
      operation_mode               = var.import_creation_mode
    }
  }

  dynamic "threat_detection_policy" {
    for_each = var.threat_detection_policy_state[count.index] != "" ? [1] : []

    content {
      state                      = var.threat_detection_policy_state
      disabled_alerts            = var.threat_detection_policy_disabled_alerts
      email_account_admins       = var.email_account_admins
      email_addresses            = var.email_addresses
      retention_days             = var.retention_days
      storage_account_access_key = var.storage_account_access_key
      storage_endpoint           = var.storage_endpoint
      use_server_default         = var.use_server_default
    }
  }

  tags = merge(
    var.tags,
    var.sql_database_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# SQL firewall rule
###

resource "azurerm_sql_firewall_rule" "this_rule" {
  count = var.enabled ? 1 : 0

  name                = var.sql_firewall_rule_name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.this[count.index].name
  start_ip_address    = var.sql_firewall_rule_start_ip_address
  end_ip_address      = var.sql_firewall_rule_end_ip_address
}

###
# MSSQL elastic pool
###

resource "azurerm_mssql_elasticpool" "this" {
  count = var.enabled ? 1 : 0

  name                = var.elastic_pool_names
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = azurerm_sql_server.this[count.index].name
  max_size_gb         = var.elastic_pool_max_size_gb
  max_size_bytes      = var.elastic_pool_max_size_bytes
  zone_redundant      = var.elastic_pool_zone_redundant

  dynamic "sku" {
    for_each = var.elastic_pool_sku_name[count.index] != "" ? [1] : []

    content {
      name     = var.elastic_pool_sku_name
      capacity = var.elastic_pool_sku_capacity
      tier     = var.elastic_pool_sku_tier
      family   = var.elastic_pool_sku_family
    }
  }

  dynamic "per_database_settings" {
    for_each = var.min_capacity[count.index] != "" ? [1] : []

    content {
      min_capacity = var.min_capacity
      max_capacity = var.max_capacity
    }
  }

  tags = merge(
    var.tags,
    var.mssql_elastic_pool_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# SQL failover group
###

resource "azurerm_sql_failover_group" "this" {
  count = var.enabled ? 1 : 0

  name                = var.sql_failover_group_names
  resource_group_name = var.resource_group_name
  server_name         = azurerm_sql_server.this[count.index].name
  database            = var.sql_failover_group_databases

  dynamic "partner_servers" {
    for_each = var.partner_servers_ids[count.index] != "" ? [1] : []

    content {
      id = var.partner_servers_ids
    }
  }

  dynamic "read_wirte_endpoint_failover_policy" {
    for_each = var.read_write_failover_policy_mode[count.index] != "" ? [1] : []

    content {
      mode          = var.read_write_failover_policy_mode
      grace_minutes = var.read_write_failover_policy_grace_minutes
    }
  }

  dynamic "readonly_endpoint_failover_policy" {
    for_each = var.readonly_failover_policy_mode[count.index] != "" ? [1] : []

    content {
      mode = var.readonly_failover_policy_mode
    }
  }

  tags = merge(
    var.tags,
    var.sql_failover_group_tags,
    {
      "Terraform" = "true"
    }
  )
}

###
# SQL vnet rule
###

resource "azurerm_sql_virtual_network_rule" "this_vnet_rule" {
  count = var.enabled ? 1 : 0

  name                                 = var.sql_vnet_rule_name
  resource_group_name                  = var.resource_group_name
  server_name                          = azurerm_sql_server.this[count.index].name
  subnet_id                            = var.sql_vnet_subnet_id
  ignore_missing_vnet_service_endpoint = var.sql_ignore_missing_vnet_service_endpoint
}

###
# SQL AD administrator
###

resource "azurerm_sql_active_directory_administrator" "this" {
  count = var.enabled ? 1 : 0

  server_name         = azurerm_sql_server.this[count.index].name
  resource_group_name = var.resource_group_name
  login               = var.sql_ad_login_name
  object_id           = var.object_ids
  tenant_id           = var.tenant_ids
}
