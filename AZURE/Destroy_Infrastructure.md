
# How to Destroy Infrastructure AZURE
Terraform Build Infrastructure Documentation can be found [here](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build)

# Table of Contents
1. [Requirements](README.md)
2. [Initialize the Directory](#initialize-the-directory)
3. [Destroy Infrastructure](#destroy-infrastructure)

Go into the directory with the `main.tf` and `terraform.tfstate` to run the terraform destroy command.

## Initialize the Directory

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the AZURE provider. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/init)

```sh
terraform init
```



<br />

Example:

```sh
$ terraform init
Initializing modules...
- bucket in github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "3.47.0"...
- Installing hashicorp/azurerm v3.47.0...
- Installed hashicorp/azurerm v3.47.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
$ 
```



<br />

```sh
terraform init
```



## Destroy Infrastructure

The terraform destroy command destroys all of the resources being managed by the current working directory and workspace, using state data to determine which real world objects correspond to managed resources. Like terraform apply, it asks for confirmation before proceeding. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/destroy)

```sh
terraform destroy
```



<br />

Example:

```sh
$ terraform destroy
module.bucket.azurerm_resource_group.resource_group[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]
module.bucket.azurerm_storage_account.storage_account[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]
module.bucket.azurerm_storage_container.storage_container[2]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3]
module.bucket.azurerm_storage_container.storage_container[1]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2]
module.bucket.azurerm_storage_container.storage_container[0]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.bucket.azurerm_resource_group.resource_group[0] will be destroyed
  - resource "azurerm_resource_group" "resource_group" {
      - id       = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group" -> null
      - location = "eastus" -> null
      - name     = "telestream-cloud-port-dev-resource-group" -> null
      - tags     = {} -> null
    }

  # module.bucket.azurerm_storage_account.storage_account[0] will be destroyed
  - resource "azurerm_storage_account" "storage_account" {
      - access_tier                       = "Hot" -> null
      - account_kind                      = "StorageV2" -> null
      - account_replication_type          = "RAGRS" -> null
      - account_tier                      = "Standard" -> null
      - allow_nested_items_to_be_public   = true -> null
      - cross_tenant_replication_enabled  = true -> null
      - default_to_oauth_authentication   = false -> null
      - enable_https_traffic_only         = true -> null
      - id                                = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount" -> null
      - infrastructure_encryption_enabled = false -> null
      - is_hns_enabled                    = false -> null
      - location                          = "eastus" -> null
      - min_tls_version                   = "TLS1_2" -> null
      - name                              = "tcaccount" -> null
      - nfsv3_enabled                     = false -> null
      - primary_access_key                = (sensitive value)
      - primary_blob_connection_string    = (sensitive value)
      - primary_blob_endpoint             = "https://tcaccount.blob.core.windows.net/" -> null
      - primary_blob_host                 = "tcaccount.blob.core.windows.net" -> null
      - primary_connection_string         = (sensitive value)
      - primary_dfs_endpoint              = "https://tcaccount.dfs.core.windows.net/" -> null
      - primary_dfs_host                  = "tcaccount.dfs.core.windows.net" -> null
      - primary_file_endpoint             = "https://tcaccount.file.core.windows.net/" -> null
      - primary_file_host                 = "tcaccount.file.core.windows.net" -> null
      - primary_location                  = "eastus" -> null
      - primary_queue_endpoint            = "https://tcaccount.queue.core.windows.net/" -> null
      - primary_queue_host                = "tcaccount.queue.core.windows.net" -> null
      - primary_table_endpoint            = "https://tcaccount.table.core.windows.net/" -> null
      - primary_table_host                = "tcaccount.table.core.windows.net" -> null
      - primary_web_endpoint              = "https://tcaccount.z13.web.core.windows.net/" -> null
      - primary_web_host                  = "tcaccount.z13.web.core.windows.net" -> null
      - public_network_access_enabled     = true -> null
      - queue_encryption_key_type         = "Service" -> null
      - resource_group_name               = "telestream-cloud-port-dev-resource-group" -> null
      - secondary_access_key              = (sensitive value)
      - secondary_blob_connection_string  = (sensitive value)
      - secondary_blob_endpoint           = "https://tcaccount-secondary.blob.core.windows.net/" -> null
      - secondary_blob_host               = "tcaccount-secondary.blob.core.windows.net" -> null
      - secondary_connection_string       = (sensitive value)
      - secondary_dfs_endpoint            = "https://tcaccount-secondary.dfs.core.windows.net/" -> null
      - secondary_dfs_host                = "tcaccount-secondary.dfs.core.windows.net" -> null
      - secondary_location                = "westus" -> null
      - secondary_queue_endpoint          = "https://tcaccount-secondary.queue.core.windows.net/" -> null
      - secondary_queue_host              = "tcaccount-secondary.queue.core.windows.net" -> null
      - secondary_table_endpoint          = "https://tcaccount-secondary.table.core.windows.net/" -> null
      - secondary_table_host              = "tcaccount-secondary.table.core.windows.net" -> null
      - secondary_web_endpoint            = "https://tcaccount-secondary.z13.web.core.windows.net/" -> null
      - secondary_web_host                = "tcaccount-secondary.z13.web.core.windows.net" -> null
      - sftp_enabled                      = false -> null
      - shared_access_key_enabled         = true -> null
      - table_encryption_key_type         = "Service" -> null
      - tags                              = {} -> null

      - blob_properties {
          - change_feed_enabled           = false -> null
          - change_feed_retention_in_days = 0 -> null
          - last_access_time_enabled      = false -> null
          - versioning_enabled            = false -> null
        }

      - network_rules {
          - bypass                     = [
              - "AzureServices",
            ] -> null
          - default_action             = "Allow" -> null
          - ip_rules                   = [] -> null
          - virtual_network_subnet_ids = [] -> null
        }

      - queue_properties {

          - hour_metrics {
              - enabled               = true -> null
              - include_apis          = true -> null
              - retention_policy_days = 7 -> null
              - version               = "1.0" -> null
            }

          - logging {
              - delete                = false -> null
              - read                  = false -> null
              - retention_policy_days = 0 -> null
              - version               = "1.0" -> null
              - write                 = false -> null
            }

          - minute_metrics {
              - enabled               = false -> null
              - include_apis          = false -> null
              - retention_policy_days = 0 -> null
              - version               = "1.0" -> null
            }
        }

      - share_properties {

          - retention_policy {
              - days = 7 -> null
            }
        }
    }

  # module.bucket.azurerm_storage_container.storage_container[0] will be destroyed
  - resource "azurerm_storage_container" "storage_container" {
      - container_access_type   = "private" -> null
      - has_immutability_policy = false -> null
      - has_legal_hold          = false -> null
      - id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-1" -> null
      - metadata                = {} -> null
      - name                    = "fake-bucket-name-1" -> null
      - resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-1" -> null
      - storage_account_name    = "tcaccount" -> null
    }

  # module.bucket.azurerm_storage_container.storage_container[1] will be destroyed
  - resource "azurerm_storage_container" "storage_container" {
      - container_access_type   = "private" -> null
      - has_immutability_policy = false -> null
      - has_legal_hold          = false -> null
      - id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-2" -> null
      - metadata                = {} -> null
      - name                    = "fake-bucket-name-2" -> null
      - resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-2" -> null
      - storage_account_name    = "tcaccount" -> null
    }

  # module.bucket.azurerm_storage_container.storage_container[2] will be destroyed
  - resource "azurerm_storage_container" "storage_container" {
      - container_access_type   = "private" -> null
      - has_immutability_policy = false -> null
      - has_legal_hold          = false -> null
      - id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-3" -> null
      - metadata                = {} -> null
      - name                    = "fake-bucket-name-3" -> null
      - resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-3" -> null
      - storage_account_name    = "tcaccount" -> null
    }

Plan: 0 to add, 0 to change, 5 to destroy.

Changes to Outputs:
  - bucket_names                                = "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3" -> null
  - storage_account_name                        = "tcaccount" -> null
  - storage_account_primary_access_key          = (sensitive value)
  - storage_account_primary_connection_string   = (sensitive value)
  - storage_account_secondary_access_key        = (sensitive value)
  - storage_account_secondary_connection_string = (sensitive value)

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.bucket.azurerm_storage_container.storage_container[1]: Destroying... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2]
module.bucket.azurerm_storage_container.storage_container[0]: Destroying... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1]
module.bucket.azurerm_storage_container.storage_container[2]: Destroying... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3]
module.bucket.azurerm_storage_container.storage_container[0]: Destruction complete after 2s
module.bucket.azurerm_storage_container.storage_container[2]: Destruction complete after 2s
module.bucket.azurerm_storage_container.storage_container[1]: Destruction complete after 3s
module.bucket.azurerm_storage_account.storage_account[0]: Destroying... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]
module.bucket.azurerm_storage_account.storage_account[0]: Destruction complete after 2s
module.bucket.azurerm_resource_group.resource_group[0]: Destroying... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]
module.bucket.azurerm_resource_group.resource_group[0]: Still destroying... [id=/subscriptions/df95b436-de1f-4c2a-96d9-...lestream-cloud-port-dev-resource-group, 10s elapsed]
module.bucket.azurerm_resource_group.resource_group[0]: Destruction complete after 16s

Destroy complete! Resources: 5 destroyed.
$ 
```