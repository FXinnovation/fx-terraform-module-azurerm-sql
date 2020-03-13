###
# General
###

variable "enabled" {
  description = "Enable or disable module"
  default     = true
}

variable "resource_group_name" {
  description = "Name of the resource group where to create the SQL server."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource"
  default     = {}
}

###
# SQL server
###

variable "sql_server_count" {
  description = "The number of SQL server this module will create. `REQUIRED`"
  default     = 1
}

variable "sql_server_names" {
  description = "The list of name of the SQL Server. This needs to be globally unique within Azure.`REQUIRED`"
  type        = list(string)
  default     = []
}

variable "sql_server_locations" {
  description = "Location of the SQL server. `REQUIRED`"
  type        = list(string)
  default     = []
}

variable "sql_server_versions" {
  description = "The list of versions for the new server.Vaild vaules are `2.0`(for v11 server) and `12.0`(for v12 server).`REQUIRED`"
  type        = list(string)
  default     = []
}

variable "sql_server_administrator_logins" {
  description = "The list of administrator login name for the new server. Changing this forces a new resource to be created.`REQUIRED`"
  type        = list(string)
  default     = []
}

variable "sql_server_administrator_login_passwords" {
  description = "List of password associated with the administrator_login user. Needs to comply with Azure's `Password Policy` https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?redirectedfrom=MSDN&view=sql-server-ver15  `REQUIRED`"
  type        = list(string)
  default     = []
}

variable "identity_type_enabled" {
  description = "Boolean flag which describes whether or not to enabled the identity block"
  type        = list(bool)
  default     = [false]
}

variable "identity_type" {
  description = "Specifies the identity type of the SQL server. At this time the only allowed value is `SystemAssigned`. "
  type        = string
  default     = "SystemAssigned"
}

variable "sql_server_tags" {
  description = "Tag which will be associated to the SQL server."
  default     = {}
}

###
# SQL database
###

variable "sql_databases_enabled" {
  description = "Boolean flag which describes whether or not to create the SQL databases."
  default     = false
}

variable "sql_database_count" {
  description = "The number of databases this module will be creating. If enabled value is `REQUIRED`"
  default     = 1
}

variable "sql_database_names" {
  description = "The list of databases which will b created.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = []
}

variable "sql_database_server_names" {
  description = "The liat of SQL server names under which the database will be created. Changing this foreces a new resource to be created.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = []
}

variable "sql_database_create_modes" {
  description = " Specifies how to create the database. Valid values are: Default, Copy, OnlineSecondary, NonReadableSecondary, PointInTimeRestore, Recovery, Restore or RestoreLongTermRetentionBackup. Must be Default to create a new database. Defaults to Default. Please see Azure SQL Database REST API. https://docs.microsoft.com/en-us/rest/api/sql/databases/createorupdate#createmode. If enabled value is `REQUIRED`"
  type        = list(string)
  default     = ["Default"]
}

variable "sql_source_database_ids" {
  description = "The URIs of the source database if `create_mode` vaule is not `Default`."
  type        = list(string)
  default     = [""]
}

variable "sql_database_restore_point_in_times" {
  description = "List which specifies point in time for the restore. Only applies if `create_mode` is `PointInTimeRestore` e.g. `2013-11-08T22:00:40Z`."
  type        = list(string)
  default     = [""]
}

variable "sql_database_default_restore_point_in_time" {
  description = "Default restore point in time for the SQL database when creation mode is not `PoinInTime`"
  default     = "2020-01-02T15:04:05Z"
}

variable "sql_database_editions" {
  description = "The list of  edition of the database to be created. Applies only if create_mode is Default. Valid values are: `Basic`, `Standard`, `Premium`, `DataWarehouse`, `Business`, `BusinessCritical`, `Free`, `GeneralPurpose`, `Hyperscale`, `Premium`, `PremiumRS`, `Standard`, `Stretch`, `System`, `System2`, or `Web`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models"
  type        = list(string)
  default     = ["GeneralPurpose"]
}

variable "sql_database_collation" {
  description = "List of names of  the collation. Applies only if `create_mode` is `Default`. Azure default is `SQL_LATIN1_GENERAL_CP1_CI_AS`. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "sql_database_max_size_bytes" {
  description = "The list of maximum size that the databases can grow to. Applies only if `create_mode` is `Default`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models"
  type        = list(string)
  default     = [""]
}

variable "sql_database_requested_service_objective_id" {
  description = "A list of GUID/UUID corresponding to a configured Service Level Objective for the Azure SQL database which can be used to configure a performance level.The default is for `West Us` location. Please check https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions link for the supported GUIDS in respective locations."
  type        = list(string)
  default     = ["3d6269f6-9ca1-4192-a947-5bff42c8c2aa"]
}

variable "sql_database_requested_service_objective_name" {
  description = "The service objective name for the database. Valid values depend on edition and location and may include `S0`, `S1`, `S2`, `S3`, `P1`, `P2`, `P4`, `P6`, `P11` and `ElasticPool`. You can list the available names with the cli: `shell az sql db list-editions -l westus --edition Standard -o table`. For further information please see Azure CLI - az sql db. https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions"
  type        = list(string)
  default     = ["GP_S_Gen5_2"]
}

variable "sql_source_database_deletion_dates" {
  description = "List which specifies the deletion date time of the source database. Only applies to deleted databases where `create_mode` is `PointInTimeRestore`."
  type        = list(string)
  default     = [""]
}

variable "sql_source_database_default_deletion_date" {
  description = "Default source database deletion date for the SQL database when creation mode is not `PoinInTime`"
  default     = "2020-01-02T15:04:05Z"
}

variable "sql_database_elastic_pool_names" {
  description = "the list of names of the  elastic database pool."
  type        = list(string)
  default     = [""]
}

variable "sql_database_read_scale" {
  description = "Read-only connections will be redirected to a high-available replica. Please see https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out."
  type        = list(bool)
  default     = [false]
}

variable "sql_database_import_enabled" {
  description = "Boolean flag which describes whether the database is imported from .bacpc file or creating new database."
  type        = list(bool)
  default     = [false]
}

variable "import_storage_uri" {
  description = "List which specifies the blob URIs of the `.bacpac` file."
  type        = list(string)
  default     = [""]
}

variable "import_storage_key" {
  description = "Specifies the access key for the storage account. "
  type        = list(string)
  default     = [""]
}

variable "import_storage_key_type" {
  description = "List which specifies the type of access key for the storage account. Valid values are `StorageAccessKey` or `SharedAccessKey`."
  type        = list(string)
  default     = ["SharedAccessKey"]
}

variable "import_administrator_login" {
  description = "List of SQL administrators names. "
  type        = list(string)
  default     = [""]
}

variable "import_administrator_login_password" {
  description = "List of  SQL administrator passwords. "
  type        = list(string)
  default     = [""]
}

variable "import_authentication_type" {
  description = "Specifies the type of authentication used to access the server. Valid values are `SQL` or `ADPassword`."
  type        = list(string)
  default     = ["SQL"]
}

variable "import_creation_mode" {
  description = "Specifies the type of import operation being performed. The only allowable value is `Import`."
  default     = "Import"
}

variable "threat_detection_policy_enabled" {
  description = "List of boolean flags which describes the threat detection policy block to be enabled or not."
  type        = list(bool)
  default     = [false]
}

variable "threat_detection_policy_state" {
  description = "The list which describes state of the policy. Possible values are `Enabled`, `Disabled` or `New`"
  type        = list(string)
  default     = [""]
}

variable "threat_detection_policy_disabled_alerts" {
  description = "Specifies a list of alerts which should be disabled. Possible values include `Access_Anomaly`, `Sql_Injection` and `Sql_Injection_Vulnerability`. "
  type        = list(list(string))
  default     = [null]
}

variable "threat_detection_policy_email_account_admins" {
  description = "List which descsibes should the account administrators be emailed when this alert is triggered?. Possible values are `Enabled`, `Disabled`"
  type        = list(string)
  default     = ["Disabled"]
}

variable "threat_detection_policy_email_addresses" {
  description = "A list of email addresses which alerts should be sent to."
  type        = list(list(string))
  default     = [null]
}

variable "threat_detection_policy_retention_days" {
  description = "A list specifies the number of days to keep in the Threat Detection audit logs."
  type        = list(number)
  default     = [10]
}

variable "threat_detection_policy_storage_account_access_key" {
  description = " Specifies the identifier key of the Threat Detection audit storage account. Required if `state` is `Enabled`."
  type        = list(string)
  default     = [""]
}

variable "threat_detection_policy_storage_endpoint" {
  description = "Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs. Required if `state` is `Enabled`."
  type        = list(string)
  default     = [""]
}

variable "threat_detection_policy_use_server_default" {
  description = "List which provides the information about should the default server policy be used? Defaults to `Disabled`."
  type        = list(string)
  default     = ["Disabled"]
}

variable "sql_database_tags" {
  description = "Tags which will be associted to the SQL database."
  default     = {}
}

###
# SQL firewall rule
###

variable "sql_firewall_rule_enabled" {
  description = "Boolean flag which describes whether or not create SQL firewall rule."
  default     = false
}

variable "sql_firewall_rule_count" {
  description = "The number of firewall rules we would like to create."
  default     = 1
}

variable "sql_firewall_rule_names" {
  description = "Names of the firewall rules.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_firewall_rule_server_names" {
  description = "the list of names of the SQL server under which the firewall rules will be created. Changing this will force to create new resource.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_firewall_rule_start_ip_address" {
  description = "List of starting IP address to allow through the firewall for this rule.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_firewall_rule_end_ip_address" {
  description = "The list of ending IP address to allow through the firewall for this rule.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

###
# MSSQL elastic pool
###
variable "mssql_elasticpool_enabled" {
  description = "Boolean flag which describes whether or not to enable the elaticpool."
  default     = false
}

variable "mssql_elastic_pool_names" {
  description = "Names of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "mssql_elastic_pool_server_names" {
  description = "The liat of SQL server names under which the elastic pool will be created. Changing this foreces a new resource to be created.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = []
}

variable "mssql_elastic_pool_max_size_gb_enabled" {
  description = "The boolean flag which describes whether you want to specify  max data size of the elastic pool in gb. Conflicts with `max_size_gb`."
  type        = list(bool)
  default     = [false]
}

variable "mssql_elastic_pool_max_size_gbs" {
  description = "The list of max data size of the elastic pool in gigabytes. Conflicts with `max_size_bytes`."
  type        = list(number)
  default     = [10]
}

variable "mssql_elastic_pool_max_size_bytes_enabled" {
  description = "The boolean flag which describes whether you want to specify max data size of the elastic pool in bytes. Conflicts with `max_size_gb`."
  type        = list(bool)
  default     = [false]
}

variable "mssql_elastic_pool_max_size_bytes" {
  description = "The max data size of the elastic pool in bytes. Conflicts with `max_size_gb`."
  type        = list(number)
  default     = [10737418240]
}

variable "mssql_elastic_pool_zone_redundant" {
  description = "Whether or not this elastic pool is zone redundant. `tier` needs to be `Premium` for `DTU` based or `BusinessCritical` for `vCore` based `sku`. Defaults to `false`."
  type        = list(bool)
  default     = [false]
}

variable "mssql_elastic_pool_sku_names" {
  description = "The names of the SKUs for the elastic pool. The name of the SKU, will be either `vCore` based `tier` + `family` pattern (e.g. GP_Gen4, BC_Gen5) or the `DTU` based `BasicPool`, `StandardPool`, or `PremiumPool` pattern.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = []
}

variable "mssql_elastic_pool_sku_capacities" {
  description = "The scale up/out capacity, representing server's compute units. For more information see the documentation for your Elasticpool configuration: `vCore-based` (https://docs.microsoft.com/en-us/azure/sql-database/sql-database-vcore-resource-limits-elastic-pools) or `DTU-based`(https://docs.microsoft.com/en-us/azure/sql-database/sql-database-dtu-resource-limits-elastic-pools). If enabled value is `REQUIRED`"
  type        = list(number)
  default     = [2]
}

variable "mssql_elastic_pool_sku_tiers" {
  description = "The tier of the particular SKU. Possible values are `GeneralPurpose`, `BusinessCritical`, `Basic`, `Standard`, or `Premium`. For more information see the documentation for your Elasticpool configuration: `vCore-based` or `DTU-based`.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = ["GeneralPurpose"]
}

variable "mssql_elatic_pool_families_enabled" {
  description = "The boolean flag which describes whether to enabled the sku familiy or not."
  type        = list(bool)
  default     = [false]
}

variable "mssql_elastic_pool_sku_families" {
  description = "The family of hardware `Gen4` or `Gen5`."
  type        = list(string)
  default     = ["Gen5"]
}

variable "per_database_settings_min_capacities" {
  description = "The minimum capacity all databases are guaranteed.If enabled value is `REQUIRED`"
  type        = list(number)
  default     = [0]
}

variable "per_database_settings_max_capacities" {
  description = "The maximum capacity any one database can consume.If enabled value is `REQUIRED`"
  type        = list(number)
  default     = [1]
}

variable "mssql_elastic_pool_tags" {
  description = "Tags which will be associated to the elastic pool."
  default     = {}
}

###
# SQL failover group
###

variable "sql_failover_group_enabled" {
  description = "Boolean flag which describes whether or not to enable the SQL failover group."
  default     = false
}

variable "sql_failover_group_count" {
  description = "The number of failover group the module will create."
  default     = 1
}

variable "sql_failover_group_names" {
  description = "The list of names  of the failover group. Changing this forces a new resource to be created.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_failover_group_server_names" {
  description = "the list of names of the SQL server under for which the failover group will be created. Changing this will force to create new resource.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_failover_group_databases_exist" {
  description = "Boolean flag which describes whether the database already exist or not.If enabled value is `REQUIRED`"
  type        = bool
  default     = false
}

variable "sql_existing_database_ids" {
  description = "A list of existing database IDs."
  type        = list(list(string))
  default     = [null]
}

variable "sql_database_id_start_indexes" {
  description = "The list of start indexes(inclusive) which corresponds to the database ID.If enabled value is `REQUIRED`"
  type        = list(number)
  default     = [0]
}

variable "sql_database_id_end_indexes" {
  description = "The list which corresponds  to the end index (exclusive) of the database ID. This value should not be greater than the length of SQL database names variable.If enabled value is `REQUIRED` "
  type        = list(number)
  default     = [1]
}

variable "partner_servers_ids" {
  description = "A list of secondary SQL servers IDs.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [null]
}

variable "read_write_failover_policy_modes" {
  description = "A read/write policy failover mode. Possible values are `Manual`, `Automatic`.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "read_write_failover_policy_grace_minutes" {
  description = "Applies only if `mode` is `Automatic`. The list which specifies the grace period in minutes before failover with data loss is attempted.If enabled value is `REQUIRED`"
  type        = list(number)
  default     = [30]
}

variable "readonly_failover_policy_modes" {
  description = "A failover policy for the read-only endpoints.Possible values are `Enabled`, and `Disabled`."
  type        = list(string)
  default     = ["Disabled"]
}

variable "sql_failover_group_tags" {
  description = "Tags which will be associated to the SQL failover groups."
  default     = {}
}


###
# SQL vnet rule
###

variable "sql_vnet_rule_count" {
  description = "Number of VNET rules we would like create for the SQL server."
  default     = 1
}

variable "sql_vnet_rule_enabled" {
  description = "Boolean flag which describes whether or not to enable the SQL virtual network rule."
  default     = false
}

variable "sql_vnet_rule_names" {
  description = "The names of the SQL virtual network rule. Changing this forces a new resource to be created. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_vnet_rule_server_names" {
  description = "the list of names of the SQL server under which the VNET rules will be created. Changing this will force to create new resource.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_vnet_subnet_ids" {
  description = "The IDs of the subnet that the SQL server will be connected to.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_ignore_missing_vnet_service_endpoints" {
  description = "Creates the virtual network rule before the subnet has the virtual network service endpoint enabled. The default value is `false`. `NOTE: If ignore_missing_vnet_service_endpoint is false, and the target subnet does not contain the Microsoft.SQL endpoint in the service_endpoints array, the deployment will fail when it tries to create the SQL virtual network rule.`"
  type        = list(bool)
  default     = [false]
}

###
# SQL AD administrator
###

variable "sql_ad_admin_count" {
  description = "The numebr AD admins we would like to create for the SQL server."
  default     = 1
}

variable "sql_ad_admin_enabled" {
  description = "Boolean flag which describes whether or not to enable the SQL active directory administrator."
  default     = false
}

variable "sql_ad_login_name" {
  description = "The names of the SQL Server on which to set the administrator. Changing this forces a new resource to be created. If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "sql_ad_admin_server_names" {
  description = "the list of names of the SQL server for which AD administrator accounts will be created. Changing this will force to create new resource.If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "object_ids" {
  description = " The IDs of the principal to set as the server administrator. If enabled value is `REQUIRED`"
  type        = list(string)
  default     = [""]
}

variable "tenant_ids" {
  description = "The Azure Tenant IDs"
  type        = list(string)
  default     = [""]
}
