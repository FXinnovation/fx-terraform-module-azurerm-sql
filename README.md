# terraform-module-azurerm-sql

## Usage
See `examples` folders for usage of this module.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

| Name | Version |
|------|---------|
| azurerm | >=1.36.0, < 2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| elastic\_pool\_max\_size\_bytes | The max data size of the elastic pool in bytes. Conflicts with `max_size_gb`. | `list(number)` | <pre>[<br>  512<br>]</pre> | no |
| elastic\_pool\_max\_size\_gb | The list of max data size of the elastic pool in gigabytes. Conflicts with `max_size_bytes`. | `list(number)` | <pre>[<br>  10<br>]</pre> | no |
| elastic\_pool\_names | Names of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| elastic\_pool\_sku\_capacity | The scale up/out capacity, representing server's compute units. For more information see the documentation for your Elasticpool configuration: `vCore-based` (https://docs.microsoft.com/en-us/azure/sql-database/sql-database-vcore-resource-limits-elastic-pools) or `DTU-based`(https://docs.microsoft.com/en-us/azure/sql-database/sql-database-dtu-resource-limits-elastic-pools). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| elastic\_pool\_sku\_family | The family of hardware `Gen4` or `Gen5`. | `list(string)` | <pre>[<br>  "Gen4"<br>]</pre> | no |
| elastic\_pool\_sku\_name | The names of the SKUs for the elastic pool. The name of the SKU, will be either `vCore` based `tier` + `family` pattern (e.g. GP\_Gen4, BC\_Gen5) or the `DTU` based `BasicPool`, `StandardPool`, or `PremiumPool` pattern. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| elastic\_pool\_sku\_tier | The tier of the particular SKU. Possible values are `GeneralPurpose`, `BusinessCritical`, `Basic`, `Standard`, or `Premium`. For more information see the documentation for your Elasticpool configuration: `vCore-based` or `DTU-based`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| email\_account\_admins | List which descsibes should the account administrators be emailed when this alert is triggered? . | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| email\_addresses | A list of email addresses which alerts should be sent to. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| enabled | Enable or disable module | `bool` | `true` | no |
| identity\_type | Specifies the identity type of the SQL server. At this time the only allowed value is `SystemAssigned`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_administrator\_login | List of SQL administrators names. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_administrator\_login\_password | List of  SQL administrator passwords. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_authentication\_type | Specifies the type of authentication used to access the server. Valid values are `SQL` or `ADPassword`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_creation\_mode | Specifies the type of import operation being performed. The only allowable value is `Import`. | `string` | `"Import"` | no |
| import\_storage\_key | Specifies the access key for the storage account. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_storage\_key\_type | List which specifies the type of access key for the storage account. Valid values are `StorageAccessKey` or `SharedAccessKey`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| import\_storage\_uri | List which specifies the blob URIs of the `.bacpac` file. | `list(string)` | n/a | yes |
| location | Location of the SQL server | `string` | n/a | yes |
| max\_capacity | The maximum capacity any one database can consume. | `list(number)` | <pre>[<br>  4<br>]</pre> | no |
| min\_capacity | The minimum capacity all databases are guaranteed. | `list(number)` | <pre>[<br>  2<br>]</pre> | no |
| mssql\_elastic\_pool\_tags | Tags which will be associated to the elastic pool. | `map` | `{}` | no |
| object\_ids | The IDs of the principal to set as the server administrator | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| partner\_servers\_ids | A list of secondary SQL servers IDs. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| read\_write\_failover\_policy\_grace\_minutes | Applies only if `mode` is `Automatic`. The list which specifies the grace period in minutes before failover with data loss is attempted. | `list(number)` | <pre>[<br>  30<br>]</pre> | no |
| read\_write\_failover\_policy\_mode | A read/write policy failover mode. Possible values are `Manual`, `Automatic`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| readonly\_failover\_policy\_mode | A failover policy for the read-only endpoints.Possible values are `Enabled`, and `Disabled`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| resource\_group\_name | Name of the resource group where to create the SQL server. | `string` | n/a | yes |
| retention\_days | A list specifies the number of days to keep in the Threat Detection audit logs. | `list(number)` | <pre>[<br>  10<br>]</pre> | no |
| sql\_ad\_login\_name | The names of the SQL Server on which to set the administrator. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_collation | List of names of  the collation. Applies only if `create_mode` is `Default`. Azure default is `SQL_LATIN1_GENERAL_CP1_CI_AS`. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_editions | The list of  edition of the database to be created. Applies only if create\_mode is Default. Valid values are: `Basic`, `Standard`, `Premium`, `DataWarehouse`, `Business`, `BusinessCritical`, `Free`, `GeneralPurpose`, `Hyperscale`, `Premium`, `PremiumRS`, `Standard`, `Stretch`, `System`, `System2`, or `Web`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_elastic\_pool\_names | the list of names of the  elastic database pool. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_max\_size\_bytes | The list of maximum size that the databases can grow to. Applies only if `create_mode` is `Default`. Please see Azure SQL Database Service Tiers. https://docs.microsoft.com/en-us/azure/sql-database/sql-database-purchase-models | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_names | The list of names of databases which will b created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_read\_scale | Read-only connections will be redirected to a high-available replica. Please see https://docs.microsoft.com/en-us/azure/sql-database/sql-database-read-scale-out. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_requested\_service\_objective\_id | A list of GUID/UUID corresponding to a configured Service Level Objective for the Azure SQL database which can be used to configure a performance level. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_requested\_service\_objective\_name | The service objective name for the database. Valid values depend on edition and location and may include `S0`, `S1`, `S2`, `S3`, `P1`, `P2`, `P4`, `P6`, `P11` and `ElasticPool`. You can list the available names with the cli: `shell az sql db list-editions -l westus --edition Standard -o table`. For further information please see Azure CLI - az sql db. https://docs.microsoft.com/en-us/cli/azure/sql/db?view=azure-cli-latest#az-sql-db-list-editions | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_restore\_point\_in\_time | List which specifies point in time for the restore. Only applies if `create_mode` is `PointInTimeRestore` e.g. `2013-11-08T22:00:40Z`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_database\_tags | Tags which will be associted to the SQL database. | `map` | `{}` | no |
| sql\_database\_zone\_redundant | Whether or not this database is zone redundant, which means the replicas of this database will be spread across multiple availability zones. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_failover\_group\_databases | List of database IDs to add to the failovr group. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| sql\_failover\_group\_names | The list of names  of the failover group. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_firewall\_rule\_end\_ip\_address | The list of ending IP address to allow through the firewall for this rule. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_firewall\_rule\_name | Names of the firewall rules. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_firewall\_rule\_start\_ip\_address | List of starting IP address to allow through the firewall for this rule. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_ignore\_missing\_vnet\_service\_endpoint | Creates the virtual network rule before the subnet has the virtual network service endpoint enabled. The default value is `false`. | `list(bool)` | <pre>[<br>  false<br>]</pre> | no |
| sql\_server\_administrator\_login | The list of administrator login name for the new server. Changing this forces a new resource to be created. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_server\_administrator\_login\_password | List of password associated with the administrator\_login user. Needs to comply with Azure's `Password Policy` https://docs.microsoft.com/en-us/sql/relational-databases/security/password-policy?redirectedfrom=MSDN&view=sql-server-ver15 | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_server\_names | The list of name of the SQL Server. This needs to be globally unique within Azure. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_server\_tags | Tag which will be associated to the SQL server. | `map` | `{}` | no |
| sql\_server\_versions | The list of versions for the new server.Vaild vaules are `2.0`(for v11 server) and `12.0`(for v12 server). | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_source\_database\_deletion\_date | List which specifies the deletion date time of the source database. Only applies to deleted databases where `create_mode` is `PointInTimeRestore`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_source\_database\_ids | The URIs of the source database if `create_mode` vaule is not `Default`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_vnet\_rule\_name | The names of the SQL virtual network rule. Changing this forces a new resource to be created. Cannot be empty and must only contain alphanumeric characters and hyphens. Cannot start with a number, and cannot start or end with a hyphen. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| sql\_vnet\_subnet\_id | The IDs of the subnet that the SQL server will be connected to. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| storage\_account\_access\_key | Specifies the identifier key of the Threat Detection audit storage account. Required if `state` is `Enabled`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| storage\_endpoint | Specifies the blob storage endpoint (e.g. https://MyAccount.blob.core.windows.net). This blob storage will hold all Threat Detection audit logs. Required if `state` is `Enabled`. | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| tags | Tags shared by all resources of this module. Will be merged with any other specific tags by resource | `map` | `{}` | no |
| tenant\_ids | The Azure Tenant IDs | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| threat\_detection\_policy\_disabled\_alerts | Specifies a list of alerts which should be disabled. Possible values include `Access_Anomaly`, `Sql_Injection` and `Sql_Injection_Vulnerability`. | `list(list(string))` | <pre>[<br>  null<br>]</pre> | no |
| threat\_detection\_policy\_state | The list which describes state of the policy. Possible values are `Enabled`, `Disabled` or `New` | `list(string)` | <pre>[<br>  ""<br>]</pre> | no |
| use\_server\_default | List which provides the information about should the default server policy be used? Defaults to `Disabled`. | `list(string)` | <pre>[<br>  "Disabled"<br>]</pre> | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
