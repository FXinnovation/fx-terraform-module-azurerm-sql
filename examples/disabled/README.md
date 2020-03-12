## Diasbled example

- This should not create any resources

## Usage
```
terraform init
terraform plan
terraform apply
terraform destroy
```
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| client\_id | Azure service principal application Id. | `string` | n/a | yes |
| client\_secret | Azure service principal application Secret. | `string` | n/a | yes |
| subscription\_id | Azure subscription Id. | `string` | n/a | yes |
| tenant\_id | Azure tenant Id. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| ad\_admin\_ids | n/a |
| database\_ids | n/a |
| database\_secondary\_locations | n/a |
| failover\_group\_databases | n/a |
| failover\_group\_ids | n/a |
| failover\_group\_partner\_servers | n/a |
| failover\_group\_servers | n/a |
| firewall\_rule\_ids | n/a |
| fqdn\_sql\_server | n/a |
| mssql\_elastic\_pool\_ids | n/a |
| sql\_server\_ids | n/a |
| vnet\_rule\_ids | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->