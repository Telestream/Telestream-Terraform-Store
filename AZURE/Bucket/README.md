## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | 3.47.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.47.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/resource_group) | resource |
| [azurerm_storage_account.storage_account](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/storage_account) | resource |
| [azurerm_storage_container.storage_container](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/resources/storage_container) | resource |
| [azurerm_resource_group.resource_group](https://registry.terraform.io/providers/hashicorp/azurerm/3.47.0/docs/data-sources/resource_group) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azurerm_resource_group"></a> [azurerm\_resource\_group](#input\_azurerm\_resource\_group) | azurerm\_resource\_group = {<br>            location                        : "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."<br>            name                            : "(Required) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."<br>            tags                            : "(Optional) A mapping of tags which should be assigned to the Resource Group"<br>            create\_new                      : "(Optional) A flag to determine if creating a new Resource Group or an existing one that is not managed by this terraform module"<br>            existing\_resource\_group\_name    : "(Required if create new is false) Specifies the name of your existing resource group."<br>        } | <pre>object({<br>    name                         = optional(string)<br>    location                     = optional(string)<br>    tags                         = optional(map(string))<br>    create_new                   = optional(string, true)<br>    existing_resource_group_name = optional(string)<br>  })</pre> | <pre>{<br>  "enabled": false<br>}</pre> | no |
| <a name="input_bucket_names"></a> [bucket\_names](#input\_bucket\_names) | The list of name for the buckets | `list(string)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) default true creates the s3 bucket if false does not create any resources | `bool` | `true` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | storage\_account = {<br>          name                      : "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."<br>          account\_tier              : "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."<br>          account\_replication\_type  : "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."<br>          account\_kind              : "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."<br>          tags                      : "(Optional) A mapping of tags to assign to the resource."<br>        } | <pre>object({<br>    name                     = optional(string)<br>    account_tier             = optional(string, "Standard")<br>    account_replication_type = optional(string, "RAGRS")<br>    tags                     = optional(map(string))<br>    account_kind             = optional(string, "StorageV2")<br>  })</pre> | `{}` | no |
| <a name="input_storage_container"></a> [storage\_container](#input\_storage\_container) | storage\_container = {<br>          container\_access\_type : "(Optional) The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private."<br>          metadata              : "(Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase."<br>        } | <pre>object({<br>    container_access_type = optional(string, "private")<br>    metadata              = optional(map(string))<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_azurerm_resource_group_id"></a> [azurerm\_resource\_group\_id](#output\_azurerm\_resource\_group\_id) | The ID of the Resource Group. |
| <a name="output_azurerm_resource_group_location"></a> [azurerm\_resource\_group\_location](#output\_azurerm\_resource\_group\_location) | The Azure Region where the Resource Group should exist. |
| <a name="output_azurerm_resource_group_name"></a> [azurerm\_resource\_group\_name](#output\_azurerm\_resource\_group\_name) | The Name of the Resource Group. |
| <a name="output_existing_resource_group_location"></a> [existing\_resource\_group\_location](#output\_existing\_resource\_group\_location) | The Azure Region where the existing Resource Group. |
| <a name="output_existing_resource_group_name"></a> [existing\_resource\_group\_name](#output\_existing\_resource\_group\_name) | The Name of the Resource Group. |
| <a name="output_storage_account_access_tier"></a> [storage\_account\_access\_tier](#output\_storage\_account\_access\_tier) | Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts |
| <a name="output_storage_account_account_kind"></a> [storage\_account\_account\_kind](#output\_storage\_account\_account\_kind) | Defines the Kind of account |
| <a name="output_storage_account_account_replication_type"></a> [storage\_account\_account\_replication\_type](#output\_storage\_account\_account\_replication\_type) | Defines the type of replication to use for this storage account |
| <a name="output_storage_account_account_tier"></a> [storage\_account\_account\_tier](#output\_storage\_account\_account\_tier) | Defines the Tier to use for this storage account |
| <a name="output_storage_account_id"></a> [storage\_account\_id](#output\_storage\_account\_id) | The ID of the Storage Account. |
| <a name="output_storage_account_identity"></a> [storage\_account\_identity](#output\_storage\_account\_identity) | An identity block. |
| <a name="output_storage_account_location"></a> [storage\_account\_location](#output\_storage\_account\_location) | Specifies the supported Azure location where the resource exists |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | Specifies the name of the storage account. |
| <a name="output_storage_account_primary_access_key"></a> [storage\_account\_primary\_access\_key](#output\_storage\_account\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_storage_account_primary_blob_endpoint"></a> [storage\_account\_primary\_blob\_endpoint](#output\_storage\_account\_primary\_blob\_endpoint) | The endpoint URL for blob storage in the primary location. |
| <a name="output_storage_account_primary_blob_host"></a> [storage\_account\_primary\_blob\_host](#output\_storage\_account\_primary\_blob\_host) | The hostname with port if applicable for blob storage in the primary location. |
| <a name="output_storage_account_primary_connection_string"></a> [storage\_account\_primary\_connection\_string](#output\_storage\_account\_primary\_connection\_string) | The connection string associated with the primary location. |
| <a name="output_storage_account_primary_dfs_endpoint"></a> [storage\_account\_primary\_dfs\_endpoint](#output\_storage\_account\_primary\_dfs\_endpoint) | The endpoint URL for DFS storage in the primary location. |
| <a name="output_storage_account_primary_dfs_host"></a> [storage\_account\_primary\_dfs\_host](#output\_storage\_account\_primary\_dfs\_host) | The hostname with port if applicable for DFS storage in the primary location. |
| <a name="output_storage_account_primary_file_endpoint"></a> [storage\_account\_primary\_file\_endpoint](#output\_storage\_account\_primary\_file\_endpoint) | The endpoint URL for file storage in the primary location. |
| <a name="output_storage_account_primary_file_host"></a> [storage\_account\_primary\_file\_host](#output\_storage\_account\_primary\_file\_host) | The hostname with port if applicable for file storage in the primary location. |
| <a name="output_storage_account_primary_location"></a> [storage\_account\_primary\_location](#output\_storage\_account\_primary\_location) | The primary location of the storage account. |
| <a name="output_storage_account_primary_queue_endpoint"></a> [storage\_account\_primary\_queue\_endpoint](#output\_storage\_account\_primary\_queue\_endpoint) | The endpoint URL for queue storage in the primary location. |
| <a name="output_storage_account_primary_queue_host"></a> [storage\_account\_primary\_queue\_host](#output\_storage\_account\_primary\_queue\_host) | The hostname with port if applicable for queue storage in the primary location. |
| <a name="output_storage_account_primary_table_endpoint"></a> [storage\_account\_primary\_table\_endpoint](#output\_storage\_account\_primary\_table\_endpoint) | The endpoint URL for table storage in the primary location. |
| <a name="output_storage_account_primary_table_host"></a> [storage\_account\_primary\_table\_host](#output\_storage\_account\_primary\_table\_host) | The hostname with port if applicable for table storage in the primary location. |
| <a name="output_storage_account_primary_web_endpoint"></a> [storage\_account\_primary\_web\_endpoint](#output\_storage\_account\_primary\_web\_endpoint) | The endpoint URL for web storage in the primary location. |
| <a name="output_storage_account_primary_web_host"></a> [storage\_account\_primary\_web\_host](#output\_storage\_account\_primary\_web\_host) | The hostname with port if applicable for web storage in the primary location. |
| <a name="output_storage_account_resource_group_name"></a> [storage\_account\_resource\_group\_name](#output\_storage\_account\_resource\_group\_name) | The name of the resource group in which to create the storage account |
| <a name="output_storage_account_secondary_access_key"></a> [storage\_account\_secondary\_access\_key](#output\_storage\_account\_secondary\_access\_key) | The secondary access key for the storage account. |
| <a name="output_storage_account_secondary_blob_endpoint"></a> [storage\_account\_secondary\_blob\_endpoint](#output\_storage\_account\_secondary\_blob\_endpoint) | The endpoint URL for blob storage in the secondary location. |
| <a name="output_storage_account_secondary_blob_host"></a> [storage\_account\_secondary\_blob\_host](#output\_storage\_account\_secondary\_blob\_host) | The hostname with port if applicable for blob storage in the secondary location. |
| <a name="output_storage_account_secondary_connection_string"></a> [storage\_account\_secondary\_connection\_string](#output\_storage\_account\_secondary\_connection\_string) | The connection string associated with the secondary location. |
| <a name="output_storage_account_secondary_dfs_endpoint"></a> [storage\_account\_secondary\_dfs\_endpoint](#output\_storage\_account\_secondary\_dfs\_endpoint) | The endpoint URL for DFS storage in the secondary location. |
| <a name="output_storage_account_secondary_dfs_host"></a> [storage\_account\_secondary\_dfs\_host](#output\_storage\_account\_secondary\_dfs\_host) | The hostname with port if applicable for DFS storage in the secondary location. |
| <a name="output_storage_account_secondary_file_endpoint"></a> [storage\_account\_secondary\_file\_endpoint](#output\_storage\_account\_secondary\_file\_endpoint) | The endpoint URL for file storage in the secondary location. |
| <a name="output_storage_account_secondary_file_host"></a> [storage\_account\_secondary\_file\_host](#output\_storage\_account\_secondary\_file\_host) | The hostname with port if applicable for file storage in the secondary location. |
| <a name="output_storage_account_secondary_location"></a> [storage\_account\_secondary\_location](#output\_storage\_account\_secondary\_location) | The secondary location of the storage account. |
| <a name="output_storage_account_secondary_queue_endpoint"></a> [storage\_account\_secondary\_queue\_endpoint](#output\_storage\_account\_secondary\_queue\_endpoint) | The endpoint URL for queue storage in the secondary location. |
| <a name="output_storage_account_secondary_queue_host"></a> [storage\_account\_secondary\_queue\_host](#output\_storage\_account\_secondary\_queue\_host) | The hostname with port if applicable for queue storage in the secondary location. |
| <a name="output_storage_account_secondary_table_endpoint"></a> [storage\_account\_secondary\_table\_endpoint](#output\_storage\_account\_secondary\_table\_endpoint) | The endpoint URL for table storage in the secondary location. |
| <a name="output_storage_account_secondary_table_host"></a> [storage\_account\_secondary\_table\_host](#output\_storage\_account\_secondary\_table\_host) | The hostname with port if applicable for table storage in the secondary location. |
| <a name="output_storage_account_secondary_web_endpoint"></a> [storage\_account\_secondary\_web\_endpoint](#output\_storage\_account\_secondary\_web\_endpoint) | The endpoint URL for web storage in the secondary location. |
| <a name="output_storage_account_secondary_web_host"></a> [storage\_account\_secondary\_web\_host](#output\_storage\_account\_secondary\_web\_host) | The hostname with port if applicable for web storage in the secondary location. |
| <a name="output_storage_container_container_access_type"></a> [storage\_container\_container\_access\_type](#output\_storage\_container\_container\_access\_type) | he Access Level configured for this Container. |
| <a name="output_storage_container_has_immutability_policy"></a> [storage\_container\_has\_immutability\_policy](#output\_storage\_container\_has\_immutability\_policy) | Is there an Immutability Policy configured on this Storage Container |
| <a name="output_storage_container_has_legal_hold"></a> [storage\_container\_has\_legal\_hold](#output\_storage\_container\_has\_legal\_hold) | Is there a Legal Hold configured on this Storage Container |
| <a name="output_storage_container_id"></a> [storage\_container\_id](#output\_storage\_container\_id) | The ID of the Storage Container. |
| <a name="output_storage_container_metadata"></a> [storage\_container\_metadata](#output\_storage\_container\_metadata) | A mapping of MetaData for this Container. |
| <a name="output_storage_container_name"></a> [storage\_container\_name](#output\_storage\_container\_name) | The name of the Container which created within the Storage Account |
| <a name="output_storage_container_resource_manager_id"></a> [storage\_container\_resource\_manager\_id](#output\_storage\_container\_resource\_manager\_id) | The Resource Manager ID of this Storage Container. |
| <a name="output_storage_container_storage_account_name"></a> [storage\_container\_storage\_account\_name](#output\_storage\_container\_storage\_account\_name) | The name of the Storage Account where the Container is created in |
