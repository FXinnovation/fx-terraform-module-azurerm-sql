# terraform-module-azurerm-sql

## Usage
See `examples` folders for usage of this module.

## Limitation
- `zone_redundant` option for `azurerm_sql_database` resource will be avaliable from when we start using the azurerm provider version `2.0.0`.
- when cretaing the SQL databases from .bacpac file and new database at same time. Create databases with import file first and then create new databases.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | >= 1.36.0, < 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enabled | Enable or disable module | `bool` | `true` | no |
| identity\_type | Specifies the identity type of the SQL server. At this time the only allowed value is `SystemAssigned`. | `string` | `"SystemAssigned"` | no |
| identity\_type\_enabled | Boolean flag which describes whether or not to enabled the identity block | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| import\_administrator\_login | List of SQL administrators names. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_administrator\_login\_password | List of  SQL administrator passwords. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_authentication\_type | Specifies the type of authentication used to access the server. Valid values are `SQL` or `ADPassword`. | `list(string)` | <pre>[<br>  "SQL"<br>]</pre> | no |
| import\_creation\_mode | Specifies the type of import operation being performed. The only allowable value is `Import`. | `string` | `"Import"` | no |
| import\_storage\_key | Specifies the access key for the storage account. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_storage\_key\_type | List which specifies the type of access key for the storage account. Valid values are `StorageAccessKey` or `SharedAccessKey`. | `list(string)` | <pre>[<br>  "SharedAccessKey"<br>]</pre> | no |
| import\_storage\_uri | List which specifies the blob URIs of the `.bacpac` file. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| mssql\_elastic\_pool\_max\_size\_bytes | The max data size of the elastic pool in bytes. Conflicts with `max_size_gb`. | `list(number)` | <pre>[<br>  10737418240<br>]</pre> | no |
| mssql\_elastic\_pool\_max\_size\_gbs | The list of max data size of the elastic pool in gigabytes. Conflicts with `max_size_bytes`. | `list(number)` | <pre>[<br>  10<br>]</pre> | no |
| mssql\_elastic\_pool\_names | Names of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| mssql\_elastic\_pool\_server\_names | The liat of SQL server names under which the elastic pool will be created. Changing this foreces a new resource to be created.If enabled value is `REQUIRED` | `list(string)` | `[]` | no |
| mssql\_elastic\_pool\_sku\_capacities | The scale up/out capacity, representing server's compute units. For more information see the documentation for your Elasticpool configuration: `vCore-based` (https://docs.microsoft.com/en-us/azure/sql-database/sql-database-vcore-resource-limits-elastic-pools) or `DTU-based`(https://docs.microsoft.com/en-us/azure/sql-database/sql-database-dtu-resource-limits-elastic-pools). If enabled value is `REQUIRED` | `list(number)` | <pre>[<br>  2<br>]</pre> | no |
| mssql\_elastic\_pool\_sku\_families | The family of hardware `Gen4` or `Gen5`. | `list(string)` | <pre>[<br>  "Gen5"<br>]</pre> | no |
| mssql\_elastic\_pool\_sku\_names | The names of the SKUs for the elastic pool. The name of the SKU, will be either `vCore` based `tier` + `family` pattern (e.g. GP\_Gen4, BC\_Gen5) or the `DTU` based `BasicPool`, `StandardPool`, or `PremiumPool` pattern.If enabled value is `REQUIRED` | `list(string)` | `[]` | no |
| mssql\_elastic\_pool\_sku\_tiers | The tier of the particular SKU. Possible values are `GeneralPurpose`, `BusinessCritical`, `Basic`, `Standard`, or `Premium`. For more information see the documentation for your Elasticpool configuration: `vCore-based` or `DTU-based`.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  "GeneralPurpose"<br>]</pre> | no |
| mssql\_elastic\_pool\_tags | Tags which will be associated to the elastic pool. | `map` | `{}` | no |
| mssql\_elastic\_pool\_zone\_redundant | Whether or not this elastic pool is zone redundant. `tier` needs to be `Premium` for `DTU` based or `BusinessCritical` for `vCore` based `sku`. Defaults to `false`. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| mssql\_elasticpool\_enabled | Boolean flag which describes whether or not to enable the elaticpool. | `bool` | `false` | no |
| mssql\_elatic\_pool\_families\_enabled | The boolean flag which describes whether to enabled the sku familiy or not. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| object\_ids | The IDs of the principal to set as the server administrator. If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| partner\_servers\_ids | A list of secondary SQL servers IDs.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  null<br>]</pre> | no |
| per\_database\_settings\_max\_capacities | The maximum capacity any one database can consume.If enabled value is `REQUIRED` | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| per\_database\_settings\_min\_capacities | The minimum capacity all databases are guaranteed.If enabled value is `REQUIRED` | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| read\_write\_failover\_policy\_grace\_minutes | Applies only if `mode` is `Automatic`. The list which specifies the grace period in minutes before failover with data loss is attempted.If enabled value is `REQUIRED` | `list(number)` | <pre>[<br>  30<br>]</pre> | no |
| read\_write\_failover\_policy\_modes | A read/write policy failover mode. Possible values are `Manual`, `Automatic`.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| readonly\_failover\_policy\_modes | A failover policy for the read-only endpoints.Possible values are `Enabled`, and `Disabled`. | `list(string)` | <pre>[<br>  "Disabled"<br>]</pre> | no |
| resource\_group\_name | Name of the resource group where to create the SQL server. | `string` | `""` | no |
| sql\_ad\_admin\_count | The numebr AD admins we would like to create for the SQL server. | `number` | `1` | no |
| sql\_ad\_admin\_enabled | Boolean flag which describes whether or not to enable the SQL active directory administrator. | `bool` | `false` | no |
| sql\_ad\_admin\_server\_names | the list of names of the SQL server for which AD administrator accounts will be created. Changing this will force to create new resource.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_ad\_login\_name | The names of the SQL Server on which to set the administrator. Changing this forces a new resource to be created. If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_collation | List of names of  the collation. Applies only if `create_mode` is `Default`. Azure default is `SQL_LATIN1_GENERAL_CP1_CI_AS`. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_count | The number of databases this module will be creating. If enabled value is `REQUIRED` | `number` | `1` | no |
| sql\_database\_create\_modes | Specifies how to create the database. Valid values are: Default, Copy, OnlineSecondary, NonReadableSecondary, PointInTimeRestore, Recovery, Restore or RestoreLongTermRetentionBackup. Must be Default to create a new database. Defaults to Default. Please see Azure SQL Database REST API. https://docs.microsoft.com/en-us/rest/api/sql/databases/createorupdate#createmode. If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  "Default"<br>]</pre> | no |
| sql\_database\_default\_restore\_point\_in\_time | Default restore point in time for the SQL database when creation mode is not `PoinInTime` | `string` | `"2020-01-02T15:04:05Z"` | no |
| sql\_database\_editions | The list of  edition of the database to be created. Applies only if create\_mode is Default. Valid values are: `Basic`, `Standard`, `Premium`, `DataWarehouse`, `Business`, `BusinessCritical`, `Free`, `GeneralPurpose`, `Hyperscale`, `Premium`, `PremiumRS`, `Standard`, `Stretch`, `System`, `System2`, or `Web`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models | `list(string)` | <pre>[<br>  "GeneralPurpose"<br>]</pre> | no |
| sql\_database\_elastic\_pool\_names | the list of names of the  elastic database pool. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_id\_end\_indexes | The list which corresponds  to the end index (exclusive) of the database ID. This value should not be greater than the length of SQL database names variable.If enabled value is `REQUIRED` | `list(number)` | <pre>[<br>  1<br>]</pre> | no |
| sql\_database\_id\_start\_indexes | The list of start indexes(inclusive) which corresponds to the database ID.If enabled value is `REQUIRED` | `list(number)` | <pre>[<br>  0<br>]</pre> | no |
| sql\_database\_import\_enabled | Boolean flag which describes whether the database is imported from .bacpc file or creating new database. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| sql\_database\_max\_size\_bytes | The list of maximum size that the databases can grow to. Applies only if `create_mode` is `Default`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_names | The list of databases which will b created.If enabled value is `REQUIRED` | `list(string)` | `[]` | no |
| sql\_database\_read\_scale | Read-only connections will be redirected to a high-available replica. Please see https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| sql\_database\_requested\_service\_objective\_id | A list of GUID/UUID corresponding to a configured Service Level Objective for the Azure SQL database which can be used to configure a performance level.The default is for `West Us` location. Please check https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions link for the supported GUIDS in respective locations. | `list(string)` | <pre>[<br>  "3d6269f6-9ca1-4192-a947-5bff42c8c2aa"<br>]</pre> | no |
| sql\_database\_requested\_service\_objective\_name | The service objective name for the database. Valid values depend on edition and location and may include `S0`, `S1`, `S2`, `S3`, `P1`, `P2`, `P4`, `P6`, `P11` and `ElasticPool`. You can list the available names with the cli: `shell az sql db list-editions -l westus --edition Standard -o table`. For further information please see Azure CLI - az sql db. https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions | `list(string)` | <pre>[<br>  "GP_S_Gen5_2"<br>]</pre> | no |
| sql\_database\_restore\_point\_in\_times | List which specifies point in time for the restore. Only applies if `create_mode` is `PointInTimeRestore` e.g. `2013-11-08T22:00:40Z`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_server\_names | The liat of SQL server names under which the database will be created. Changing this foreces a new resource to be created.If enabled value is `REQUIRED` | `list(string)` | `[]` | no |
| sql\_database\_tags | Tags which will be associted to the SQL database. | `map` | `{}` | no |
| sql\_databases\_enabled | Boolean flag which describes whether or not to create the SQL databases. | `bool` | `false` | no |
| sql\_existing\_database\_ids | A list of existing database IDs. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| sql\_failover\_group\_count | The number of failover group the module will create. | `number` | `1` | no |
| sql\_failover\_group\_databases\_exist | Boolean flag which describes whether the database already exist or not.If enabled value is `REQUIRED` | `bool` | `false` | no |
| sql\_failover\_group\_enabled | Boolean flag which describes whether or not to enable the SQL failover group. | `bool` | `false` | no |
| sql\_failover\_group\_names | The list of names  of the failover group. Changing this forces a new resource to be created.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_failover\_group\_server\_names | the list of names of the SQL server under for which the failover group will be created. Changing this will force to create new resource.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_failover\_group\_tags | Tags which will be associated to the SQL failover groups. | `map` | `{}` | no |
| sql\_firewall\_rule\_count | The number of firewall rules we would like to create. | `number` | `1` | no |
| sql\_firewall\_rule\_enabled | Boolean flag which describes whether or not create SQL firewall rule. | `bool` | `false` | no |
| sql\_firewall\_rule\_end\_ip\_address | The list of ending IP address to allow through the firewall for this rule.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_firewall\_rule\_names | Names of the firewall rules.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_firewall\_rule\_server\_names | the list of names of the SQL server under which the firewall rules will be created. Changing this will force to create new resource.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_firewall\_rule\_start\_ip\_address | List of starting IP address to allow through the firewall for this rule.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_ignore\_missing\_vnet\_service\_endpoints | Creates the virtual network rule before the subnet has the virtual network service endpoint enabled. The default value is `false`. `NOTE: If ignore_missing_vnet_service_endpoint is false, and the target subnet does not contain the Microsoft.SQL endpoint in the service_endpoints array, the deployment will fail when it tries to create the SQL virtual network rule.` | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| sql\_server\_administrator\_login\_passwords | List of password associated with the administrator\_login user. Needs to comply with Azure's `Password Policy` https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?redirectedfrom=MSDN&view=sql-server-ver15  `REQUIRED` | `list(string)` | `[]` | no |
| sql\_server\_administrator\_logins | The list of administrator login name for the new server. Changing this forces a new resource to be created.`REQUIRED` | `list(string)` | `[]` | no |
| sql\_server\_count | The number of SQL server this module will create. `REQUIRED` | `number` | `1` | no |
| sql\_server\_locations | Location of the SQL server. `REQUIRED` | `list(string)` | `[]` | no |
| sql\_server\_names | The list of name of the SQL Server. This needs to be globally unique within Azure.`REQUIRED` | `list(string)` | `[]` | no |
| sql\_server\_tags | Tag which will be associated to the SQL server. | `map` | `{}` | no |
| sql\_server\_versions | The list of versions for the new server.Vaild vaules are `2.0`(for v11 server) and `12.0`(for v12 server).`REQUIRED` | `list(string)` | `[]` | no |
| sql\_source\_database\_default\_deletion\_date | Default source database deletion date for the SQL database when creation mode is not `PoinInTime` | `string` | `"2020-01-02T15:04:05Z"` | no |
| sql\_source\_database\_deletion\_dates | List which specifies the deletion date time of the source database. Only applies to deleted databases where `create_mode` is `PointInTimeRestore`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_source\_database\_ids | The URIs of the source database if `create_mode` vaule is not `Default`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_vnet\_rule\_count | Number of VNET rules we would like create for the SQL server. | `number` | `1` | no |
| sql\_vnet\_rule\_enabled | Boolean flag which describes whether or not to enable the SQL virtual network rule. | `bool` | `false` | no |
| sql\_vnet\_rule\_names | The names of the SQL virtual network rule. Changing this forces a new resource to be created. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_vnet\_rule\_server\_names | the list of names of the SQL server under which the VNET rules will be created. Changing this will force to create new resource.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_vnet\_subnet\_ids | The IDs of the subnet that the SQL server will be connected to.If enabled value is `REQUIRED` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource | `map` | `{}` | no |
| tenant\_ids | The Azure Tenant IDs | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| threat\_detection\_policy\_disabled\_alerts | Specifies a list of alerts which should be disabled. Possible values include `Access_Anomaly`, `Sql_Injection` and `Sql_Injection_Vulnerability`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| threat\_detection\_policy\_email\_account\_admins | List which descsibes should the account administrators be emailed when this alert is triggered?. Possible values are `Enabled`, `Disabled` | `list(string)` | <pre>[<br>  "Disabled"<br>]</pre> | no |
| threat\_detection\_policy\_email\_addresses | A list of email addresses which alerts should be sent to. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| threat\_detection\_policy\_enabled | List of boolean flags which describes the threat detection policy block to be enabled or not. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| threat\_detection\_policy\_retention\_days | A list specifies the number of days to keep in the Threat Detection audit logs. | `list(number)` | <pre>[<br>  10<br>]</pre> | no |
| threat\_detection\_policy\_state | The list which describes state of the policy. Possible values are `Enabled`, `Disabled` or `New` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| threat\_detection\_policy\_storage\_account\_access\_key | Specifies the identifier key of the Threat Detection audit storage account. Required if `state` is `Enabled`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| threat\_detection\_policy\_storage\_endpoint | Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs. Required if `state` is `Enabled`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| threat\_detection\_policy\_use\_server\_default | List which provides the information about should the default server policy be used? Defaults to `Disabled`. | `list(string)` | <pre>[<br>  "Disabled"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| mssql\_elastic\_pool\_ids | The IDs of the MS SQL elastic pools. |
| sql\_ad\_admin\_ids | The IDs od the SQL AD administratot. |
| sql\_database\_creation\_date | The dates at which SQL database was created. |
| sql\_database\_ids | The IDs of the SQL databases. |
| sql\_database\_secondary\_locations | The default secondary location of the SQL databases. |
| sql\_failover\_group\_databases | The list of databases in the failover group. |
| sql\_failover\_group\_ids | The IDs of the failover groups. |
| sql\_failover\_group\_locations | The locations of the failover group |
| sql\_failover\_group\_partner\_servers | The list of partner server information for the failover group. |
| sql\_failover\_group\_role | The local replication roles of the failover group instances. |
| sql\_failover\_group\_servers | The names of the primary SQL database server. |
| sql\_firewall\_rule\_ids | The IDs of the SQL firewall rules. |
| sql\_server\_fqdns | The fully qualified domain names of the SQL servers. |
| sql\_server\_ids | IDs of the SQL servers. |
| sql\_vnet\_rule\_ids | The IDs of the SQL virtual network rules. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
