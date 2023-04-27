# Terraform Module: create storage container and resource group
This Terraform module creates one or more Azure Storage Containers based on the inputted bucket names. Each bucket name must be unique within a given storage account, every container must have a unique name. The module also creates an Storage account with primary/secondary access keys and primary/secondary connection string that have access to all the created Storage Containers with permissions required by the stores. Additionally, this module will cretae a new Azure resource group that the storage containers will be in.
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | List of bucket names created |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | name of the storage account |
| <a name="output_storage_account_primary_access_key"></a> [storage\_account\_primary\_access\_key](#output\_storage\_account\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_storage_account_primary_connection_string"></a> [storage\_account\_primary\_connection\_string](#output\_storage\_account\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_storage_account_secondary_access_key"></a> [storage\_account\_secondary\_access\_key](#output\_storage\_account\_secondary\_access\_key) | The secondary access key for the storage account. |
| <a name="output_storage_account_secondary_connection_string"></a> [storage\_account\_secondary\_connection\_string](#output\_storage\_account\_secondary\_connection\_string) | The connection string associated with the secondary location. |
