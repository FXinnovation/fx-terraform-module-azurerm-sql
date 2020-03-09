data "azurerm_client_config" "current" {
}
resource "random_string" "this" {
  length  = 6
  upper   = false
  special = false
}

resource "azurerm_resource_group" "example" {
  name     = "tftest${random_string.this.result}"
  location = "West US"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "tftest-vnet${random_string.this.result}"
  address_space       = ["10.7.29.0/29"]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "tftest-subnet${random_string.this.result}"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = "10.7.29.0/29"
  service_endpoints    = ["Microsoft.Sql"]
}

resource "random_id" "server" {
  keepers = {
    ami_id = 1
  }

  byte_length = 8
}

resource "azurerm_key_vault" "example" {
  name                = format("%s%s", "tftest", random_id.server.hex)
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tenant_id           = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  access_policy {
    tenant_id = data.azurerm_client_config.current.tenant_id
    object_id = data.azurerm_client_config.current.object_id

    key_permissions = [
      "create",
      "list",
      "get",
    ]

    secret_permissions = [
      "set",
      "get",
      "list",
      "delete",
    ]
  }
}

resource "azurerm_key_vault_secret" "example" {
  name         = "sql-tftest"
  value        = "bobBAZCA%$!#123${random_string.this.result}"
  key_vault_id = azurerm_key_vault.example.id
}


module "example" {
  source = "../.."

  resource_group_name                      = azurerm_resource_group.example.name
  sql_server_count                         = 4
  sql_server_names                         = ["tftest1${random_string.this.result}", "tftest2${random_string.this.result}", "tftest3${random_string.this.result}", "tftest4${random_string.this.result}"]
  sql_server_locations                     = ["${azurerm_resource_group.example.location}", "${azurerm_resource_group.example.location}", "France central", "France central"]
  sql_server_versions                      = ["12.0"]
  sql_server_administrator_logins          = ["test"]
  sql_server_administrator_login_passwords = ["${azurerm_key_vault_secret.example.value}"]


  mssql_elasticpool_enabled            = true
  mssql_elastic_pool_names             = ["tftest-elasticpool${random_string.this.result}", "tftest-elasticpool2${random_string.this.result}"]
  mssql_elastic_pool_locations         = ["${azurerm_resource_group.example.location}", "France central"]
  mssql_elastic_pool_server_names      = ["tftest1${random_string.this.result}", "tftest3${random_string.this.result}"]
  mssql_elastic_pool_sku_names         = ["GP_Gen5"]
  mssql_elastic_pool_sku_capacities    = [2]
  mssql_elastic_pool_sku_tiers         = ["GeneralPurpose"]
  mssql_elastic_pool_sku_families      = ["Gen5"]
  mssql_elastic_pool_max_size_gbs      = [10]
  per_database_settings_min_capacities = [0]
  per_database_settings_max_capacities = [1]

  sql_databases_enabled     = true
  sql_database_count        = 4
  sql_database_names        = ["tftest1${random_string.this.result}", "tftest2${random_string.this.result}", "tftest3${random_string.this.result}", "tftest4${random_string.this.result}"]
  sql_database_locations    = ["${azurerm_resource_group.example.location}", "${azurerm_resource_group.example.location}", "France central", "France central"]
  sql_database_server_names = ["tftest1${random_string.this.result}", "tftest1${random_string.this.result}", "tftest3${random_string.this.result}", "tftest3${random_string.this.result}"]

  sql_failover_group_enabled      = true
  sql_failover_group_count        = 2
  sql_failover_group_names        = ["tftestfg1${random_string.this.result}", "tftestfg2${random_string.this.result}"]
  sql_failover_group_server_names = ["tftest1${random_string.this.result}", "tftest3${random_string.this.result}"]
  sql_database_id_start_indexes   = [0, 2]
  sql_database_id_end_indexes     = [2, 4]

  partner_servers_ids                      = ["tftest4${random_string.this.result}", "tftest2${random_string.this.result}"]
  read_write_failover_policy_modes         = ["Automatic"]
  read_write_failover_policy_grace_minutes = [60]


  sql_vnet_rule_enabled                     = true
  sql_vnet_rule_names                       = ["tftest-rule${random_string.this.result}"]
  sql_vnet_rule_server_names                = ["tftest1${random_string.this.result}"]
  sql_vnet_subnet_ids                       = ["${azurerm_subnet.subnet.id}"]
  sql_ignore_missing_vnet_service_endpoints = [true]
}
