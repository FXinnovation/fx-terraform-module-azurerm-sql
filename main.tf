###
# SQL server
###

resource "azurerm_sql_server" "this" {
  count = var.enabled ? var.sql_server_count : 0

  name                         = element(var.sql_server_names, count.index)
  resource_group_name          = var.resource_group_name
  location                     = element(var.sql_server_locations, count.index)
  version                      = element(var.sql_server_versions, count.index)
  administrator_login          = element(var.sql_server_administrator_logins, count.index)
  administrator_login_password = element(var.sql_server_administrator_login_passwords, count.index)

  dynamic "identity" {
    for_each = element(var.identity_type_enabled, count.index) == true ? [1] : []

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

resource "azurerm_sql_database" "this" {
  count = local.should_create_sql_databases ? var.sql_database_count : 0

  name                             = element(var.sql_database_names, count.index)
  resource_group_name              = var.resource_group_name
  location                         = var.sql_server_count > 1 ? lookup(local.sql_server_location, element(var.sql_database_server_names, count.index)) : element(concat(azurerm_sql_server.this.*.location, list("")), 0)
  server_name                      = var.sql_server_count > 1 ? lookup(local.sql_server_name, element(var.sql_database_server_names, count.index)) : element(concat(azurerm_sql_server.this.*.name, list("")), 0)
  create_mode                      = element(var.sql_database_create_modes, count.index)
  source_database_id               = element(var.sql_database_create_modes, count.index) != "Default" ? element(var.sql_source_database_ids, count.index) : ""
  restore_point_in_time            = element(var.sql_database_create_modes, count.index) == "PointInTimeRestore" ? element(var.sql_database_restore_point_in_times, count.index) : var.sql_database_default_restore_point_in_time
  edition                          = element(var.sql_database_editions, count.index)
  collation                        = element(var.sql_database_create_modes, count.index) == "Default" ? "SQL_LATIN1_GENERAL_CP1_CI_AS" : element(var.sql_database_collation, count.index)
  max_size_bytes                   = element(var.sql_database_create_modes, count.index) == "Default" ? element(var.sql_database_max_size_bytes, count.index) : ""
  requested_service_objective_id   = element(var.sql_database_editions, count.index) != "Basic" ? element(var.sql_database_requested_service_objective_id, count.index) : null
  requested_service_objective_name = element(var.sql_database_requested_service_objective_name, count.index)
  source_database_deletion_date    = element(var.sql_database_create_modes, count.index) == "PointInTimeRestore" ? element(var.sql_source_database_deletion_dates, count.index) : var.sql_source_database_default_deletion_date
  elastic_pool_name                = element(var.sql_database_elastic_pool_names, count.index)
  read_scale                       = element(var.sql_database_read_scale, count.index)

  dynamic "import" {
    for_each = element(var.sql_database_create_modes, count.index) == "Default" && element(var.sql_database_import_enabled, count.index) != false ? [1] : []

    content {
      storage_uri                  = element(var.import_storage_uri, count.index)
      storage_key                  = element(var.import_storage_key, count.index)
      storage_key_type             = element(var.import_storage_key_type, count.index)
      administrator_login          = element(var.import_administrator_login, count.index)
      administrator_login_password = element(var.import_administrator_login_password, count.index)
      authentication_type          = element(var.import_authentication_type, count.index)
      operation_mode               = var.import_creation_mode
    }
  }

  dynamic "threat_detection_policy" {
    for_each = element(var.threat_detection_policy_state, count.index) != "" ? [1] : []

    content {
      state                      = element(var.threat_detection_policy_state, count.index)
      disabled_alerts            = element(var.threat_detection_policy_disabled_alerts, count.index)
      email_account_admins       = element(var.threat_detection_policy_email_account_admins, count.index)
      email_addresses            = element(var.threat_detection_policy_email_addresses, count.index)
      retention_days             = element(var.threat_detection_policy_retention_days, count.index)
      storage_account_access_key = element(var.threat_detection_policy_state, count.index) == "Enabled" ? element(var.threat_detection_policy_storage_account_access_key, count.index) : ""
      storage_endpoint           = element(var.threat_detection_policy_state, count.index) == "Enabled" ? element(var.threat_detection_policy_storage_endpoint, count.index) : ""
      use_server_default         = element(var.threat_detection_policy_use_server_default, count.index)
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

resource "azurerm_sql_firewall_rule" "this" {
  count = local.should_create_sql_firewall_rule ? var.sql_firewall_rule_count : 0

  name                = element(var.sql_firewall_rule_names, count.index)
  resource_group_name = var.resource_group_name
  server_name         = var.sql_server_count > 1 ? lookup(local.sql_server_name, element(var.sql_firewall_rule_server_names, count.index), null) : element(concat(azurerm_sql_server.this.*.name, list("")), 0)
  start_ip_address    = element(var.sql_firewall_rule_start_ip_address, count.index)
  end_ip_address      = element(var.sql_firewall_rule_end_ip_address, count.index)
}

###
# MSSQL elastic pool
###

resource "azurerm_mssql_elasticpool" "this" {
  count = local.should_create_mssql_elasticpool ? length(var.mssql_elastic_pool_names) : 0

  name                = element(var.mssql_elastic_pool_names, count.index)
  resource_group_name = var.resource_group_name
  location            = var.sql_server_count > 1 ? lookup(local.sql_server_location, element(var.mssql_elastic_pool_server_names, count.index), null) : element(concat(azurerm_sql_server.this.*.location, list("")), 0)
  server_name         = var.sql_server_count > 1 ? lookup(local.sql_server_name, element(var.mssql_elastic_pool_server_names, count.index), null) : element(concat(azurerm_sql_server.this.*.name, list("")), 0)
  max_size_gb         = element(var.mssql_elastic_pool_max_size_gb_enabled, count.index) == true ? element(var.mssql_elastic_pool_max_size_gbs, count.index) : null
  max_size_bytes      = element(var.mssql_elastic_pool_max_size_bytes_enabled, count.index) == true ? element(var.mssql_elastic_pool_max_size_bytes, count.index) : null
  zone_redundant      = element(var.mssql_elastic_pool_zone_redundant, count.index)

  dynamic "sku" {
    for_each = element(var.mssql_elastic_pool_sku_names, count.index) != "" ? [1] : []

    content {
      name     = element(var.mssql_elastic_pool_sku_names, count.index)
      capacity = element(var.mssql_elastic_pool_sku_capacities, count.index)
      tier     = element(var.mssql_elastic_pool_sku_tiers, count.index)
      family   = element(var.mssql_elatic_pool_families_enabled, count.index) == true ? element(var.mssql_elastic_pool_sku_families, count.index) : null
    }
  }

  dynamic "per_database_settings" {
    for_each = element(var.per_database_settings_min_capacities, count.index) != "" ? [1] : []

    content {
      min_capacity = element(var.per_database_settings_min_capacities, count.index)
      max_capacity = element(var.per_database_settings_max_capacities, count.index)
    }
  }
  depends_on = [azurerm_sql_server.this]
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
  count = local.should_create_sql_failover_group ? var.sql_failover_group_count : 0

  name                = element(var.sql_failover_group_names, count.index)
  resource_group_name = var.resource_group_name
  server_name         = var.sql_server_count > 1 ? lookup(local.sql_server_name, element(var.sql_failover_group_server_names, count.index), null) : element(concat(azurerm_sql_server.this.*.name, list("")), 0)
  databases           = var.sql_failover_group_databases_exist ? element(var.sql_existing_database_ids, count.index) : slice(compact(concat(azurerm_sql_database.this.*.id, [""])), element(var.sql_database_id_start_indexes, count.index), element(var.sql_database_id_end_indexes, count.index))

  dynamic "partner_servers" {
    for_each = element(var.partner_servers_ids, count.index) != "" ? [1] : []

    content {
      id = lookup(local.sql_server_id, element(var.partner_servers_ids, count.index), null)
    }
  }

  dynamic "read_write_endpoint_failover_policy" {
    for_each = element(var.read_write_failover_policy_modes, count.index) != "" ? [1] : []

    content {
      mode          = element(var.read_write_failover_policy_modes, count.index)
      grace_minutes = element(var.read_write_failover_policy_grace_minutes, count.index) == "Automatic" ? element(var.read_write_failover_policy_grace_minutes, count.index) : null
    }
  }

  dynamic "readonly_endpoint_failover_policy" {
    for_each = element(var.readonly_failover_policy_modes, count.index) != "" ? [1] : []

    content {
      mode = element(var.readonly_failover_policy_modes, count.index)
    }
  }

  depends_on = [azurerm_sql_server.this]
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
  count = local.should_create_sql_vnet_rule ? var.sql_vnet_rule_count : 0

  name                                 = element(var.sql_vnet_rule_names, count.index)
  resource_group_name                  = var.resource_group_name
  server_name                          = var.sql_server_count > 1 ? lookup(local.sql_server_name, element(var.sql_vnet_rule_server_names, count.index), null) : element(concat(azurerm_sql_server.this.*.name, list("")), 0)
  subnet_id                            = element(var.sql_vnet_subnet_ids, count.index)
  ignore_missing_vnet_service_endpoint = element(var.sql_ignore_missing_vnet_service_endpoints, count.index)
}

###
# SQL AD administrator
###

resource "azurerm_sql_active_directory_administrator" "this" {
  count = local.should_create_sql_ad_admin ? var.sql_ad_admin_count : 0

  server_name         = var.sql_server_count > 1 ? lookup(local.sql_server_name, element(var.sql_ad_admin_server_names, count.index), null) : element(concat(azurerm_sql_server.this.*.name, list("")), 0)
  resource_group_name = var.resource_group_name
  login               = element(var.sql_ad_login_name, count.index)
  object_id           = element(var.object_ids, count.index)
  tenant_id           = element(var.tenant_ids, count.index)
}
