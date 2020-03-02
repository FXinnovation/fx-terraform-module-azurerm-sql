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
}

variable "location" {
  description = "Location of the SQL server"
  type        = string
}

variable "tags" {
  description = "Tags shared by all resources of this module. Will be merged with any other specific tags by resource"
  default     = {}
}

###
# SQL server
###

variable "sql_server_names" {
  description = "The list of name of the SQL Server. This needs to be globally unique within Azure."
  type        = list(string)
  default     = [""]
}

variable "sql_server_versions" {
  description = "The list of versions for the new server.Vaild vaules are `2.0`(for v11 server) and `12.0`(for v12 server)."
  type        = list(string)
  default     = [""]
}

variable "sql_server_administrator_login" {
  description = "The list of administrator login name for the new server. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "sql_server_administrator_login_password" {
  description = "List of password associated with the administrator_login user. Needs to comply with Azure's `Password Policy` https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?redirectedfrom=MSDN&view=sql-server-ver15"
  type        = list(string)
  default     = [""]
}

variable "identity_type" {
  description = "Specifies the identity type of the SQL server. At this time the only allowed value is `SystemAssigned`. "
  type        = list(string)
  default     = [""]
}

variable "sql_server_tags" {
  description = "Tag which will be associated to the SQL server."
  default     = {}
}

###
# SQL database
###

variable "sql_database_names" {
  description = "The list of names of databases which will b created."
  type        = list(string)
  default     = [""]
}

variable "sql_source_database_ids" {
  description = "The URIs of the source database if `create_mode` vaule is not `Default`."
  type        = list(string)
  default     = [""]
}

variable "sql_database_restore_point_in_time" {
  description = "List which specifies point in time for the restore. Only applies if `create_mode` is `PointInTimeRestore` e.g. `2013-11-08T22:00:40Z`."
  type        = list(string)
  default     = [""]
}

variable "sql_database_editions" {
  description = "The list of  edition of the database to be created. Applies only if create_mode is Default. Valid values are: `Basic`, `Standard`, `Premium`, `DataWarehouse`, `Business`, `BusinessCritical`, `Free`, `GeneralPurpose`, `Hyperscale`, `Premium`, `PremiumRS`, `Standard`, `Stretch`, `System`, `System2`, or `Web`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models"
  type        = list(string)
  default     = [""]
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
  description = "A list of GUID/UUID corresponding to a configured Service Level Objective for the Azure SQL database which can be used to configure a performance level."
  type        = list(string)
  default     = [""]
}

variable "sql_database_requested_service_objective_name" {
  description = "The service objective name for the database. Valid values depend on edition and location and may include `S0`, `S1`, `S2`, `S3`, `P1`, `P2`, `P4`, `P6`, `P11` and `ElasticPool`. You can list the available names with the cli: `shell az sql db list-editions -l westus --edition Standard -o table`. For further information please see Azure CLI - az sql db. https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions"
  type        = list(string)
  default     = [""]
}

variable "sql_source_database_deletion_date" {
  description = "List which specifies the deletion date time of the source database. Only applies to deleted databases where `create_mode` is `PointInTimeRestore`."
  type        = list(string)
  default     = [""]
}

variable "sql_database_elastic_pool_names" {
  description = "the list of names of the  elastic database pool."
  type        = list(string)
  default     = [""]
}

variable "sql_database_read_scale" {
  description = "Read-only connections will be redirected to a high-available replica. Please see https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out."
  type        = list(string)
  default     = [""]
}

variable "sql_database_zone_redundant" {
  description = "Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones."
  type        = list(string)
  default     = [""]
}

variable "import_storage_uri" {
  description = "List which specifies the blob URIs of the `.bacpac` file."
  type        = list(string)
}

variable "import_storage_key" {
  description = "Specifies the access key for the storage account. "
  type        = list(string)
  default     = [""]
}

variable "import_storage_key_type" {
  description = "List which specifies the type of access key for the storage account. Valid values are `StorageAccessKey` or `SharedAccessKey`."
  type        = list(string)
  default     = [""]
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
  default     = [""]
}

variable "import_creation_mode" {
  description = "Specifies the type of import operation being performed. The only allowable value is `Import`."
  default     = "Import"
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

variable "email_account_admins" {
  description = "List which descsibes should the account administrators be emailed when this alert is triggered? ."
  type        = list(string)
  default     = [""]
}

variable "email_addresses" {
  description = "A list of email addresses which alerts should be sent to."
  type        = list(list(string))
  default     = [null]
}

variable "retention_days" {
  description = "A list specifies the number of days to keep in the Threat Detection audit logs."
  type        = list(number)
  default     = [10]
}

variable "storage_account_access_key" {
  description = " Specifies the identifier key of the Threat Detection audit storage account. Required if `state` is `Enabled`."
  type        = list(string)
  default     = [""]
}

variable "storage_endpoint" {
  description = "Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs. Required if `state` is `Enabled`."
  type        = list(string)
  default     = [""]
}

variable "use_server_default" {
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

variable "sql_firewall_rule_name" {
  description = "Names of the firewall rules."
  type        = list(string)
  default     = [""]
}

variable "sql_firewall_rule_start_ip_address" {
  description = "List of starting IP address to allow through the firewall for this rule."
  type        = list(string)
  default     = [""]
}

variable "sql_firewall_rule_end_ip_address" {
  description = "The list of ending IP address to allow through the firewall for this rule."
  type        = list(string)
  default     = [""]
}

###
# MSSQL elastic pool
###

variable "elastic_pool_names" {
  description = "Names of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "elastic_pool_max_size_gb" {
  description = "The list of max data size of the elastic pool in gigabytes. Conflicts with `max_size_bytes`."
  type        = list(number)
  default     = [10]
}

variable "elastic_pool_max_size_bytes" {
  description = " The max data size of the elastic pool in bytes. Conflicts with `max_size_gb`."
  type        = list(number)
  default     = [512]
}

variable "elastic_pool_sku_name" {
  description = "The names of the SKUs for the elastic pool. The name of the SKU, will be either `vCore` based `tier` + `family` pattern (e.g. GP_Gen4, BC_Gen5) or the `DTU` based `BasicPool`, `StandardPool`, or `PremiumPool` pattern."
  type        = list(string)
  default     = [""]
}

variable "elastic_pool_sku_capacity" {
  description = "The scale up/out capacity, representing server's compute units. For more information see the documentation for your Elasticpool configuration: `vCore-based` (https://docs.microsoft.com/en-us/azure/sql-database/sql-database-vcore-resource-limits-elastic-pools) or `DTU-based`(https://docs.microsoft.com/en-us/azure/sql-database/sql-database-dtu-resource-limits-elastic-pools)."
  type        = list(string)
  default     = [""]
}

variable "elastic_pool_sku_tier" {
  description = "The tier of the particular SKU. Possible values are `GeneralPurpose`, `BusinessCritical`, `Basic`, `Standard`, or `Premium`. For more information see the documentation for your Elasticpool configuration: `vCore-based` or `DTU-based`."
  type        = list(string)
  default     = [""]
}

variable "elastic_pool_sku_family" {
  description = " The family of hardware `Gen4` or `Gen5`."
  type        = list(string)
  default     = ["Gen4"]
}

variable "min_capacity" {
  description = "The minimum capacity all databases are guaranteed."
  type        = list(number)
  default     = [2]
}

variable "max_capacity" {
  description = "The maximum capacity any one database can consume."
  type        = list(number)
  default     = [4]
}

variable "mssql_elastic_pool_tags" {
  description = "Tags which will be associated to the elastic pool."
  default     = {}
}

###
# SQL failover group
###

variable "sql_failover_group_names" {
  description = "The list of names  of the failover group. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "sql_failover_group_databases" {
  description = "List of database IDs to add to the failovr group."
  type        = list(list(string))
  default     = [null]
}

variable "partner_servers_ids" {
  description = "A list of secondary SQL servers IDs."
  type        = list(list(string))
  default     = [null]
}

variable "read_write_failover_policy_mode" {
  description = "A read/write policy failover mode. Possible values are `Manual`, `Automatic`."
  type        = list(string)
  default     = [""]
}

variable "read_write_failover_policy_grace_minutes" {
  description = "Applies only if `mode` is `Automatic`. The list which specifies the grace period in minutes before failover with data loss is attempted."
  type        = list(number)
  default     = [30]
}

variable "readonly_failover_policy_mode" {
  description = "A failover policy for the read-only endpoints.Possible values are `Enabled`, and `Disabled`."
  type        = list(string)
  default     = [""]
}

###
# SQL vnet rule
###

variable "sql_vnet_rule_name" {
  description = "The names of the SQL virtual network rule. Changing this forces a new resource to be created. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen."
  type        = list(string)
  default     = [""]
}

variable "sql_vnet_subnet_id" {
  description = "The IDs of the subnet that the SQL server will be connected to."
  type        = list(string)
  default     = [""]
}

variable "sql_ignore_missing_vnet_service_endpoint" {
  description = "Creates the virtual network rule before the subnet has the virtual network service endpoint enabled. The default value is `false`."
  type        = list(bool)
  default     = [false]
}

###
# SQL AD administrator
###

variable "sql_ad_login_name" {
  description = "The names of the SQL Server on which to set the administrator. Changing this forces a new resource to be created."
  type        = list(string)
  default     = [""]
}

variable "object_ids" {
  description = " The IDs of the principal to set as the server administrator"
  type        = list(string)
  default     = [""]
}

variable "tenant_ids" {
  description = "The Azure Tenant IDs"
  type        = list(string)
  default     = [""]
}
