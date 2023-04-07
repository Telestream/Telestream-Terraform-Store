# How to Deploy Infrastructure
Terraform Build Infrastructure Documentation can be found [here][terraform-build-infrastructure]

# Table of Contents
1. [Requirements](README.md)
2. [Copy Module](#copy-a-module)
3. [Replace values in module](#replace-values-in-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build
[terraform-init]:https://developer.hashicorp.com/terraform/cli/commands/init
[terraform-plan]:https://developer.hashicorp.com/terraform/cli/commands/plan
[terraform-apply]:https://developer.hashicorp.com/terraform/cli/commands/apply
[examples]:https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AZURE/Examples
[example]:https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AZURE/Examples/create_storage_container_and_resource_group

# Copy a module
Copy the module in [Examples][examples] directory that fits your requirements. Example module in examples will be the [create_storeage_container_and_resource_group][example] module# Replace values in module
Original:
```json
provider "azurerm" {
  # Configuration options
  features {
  }
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket"
  bucket_names = ["<replace_with_unique_name_of_bucket>"]
  azurerm_resource_group = {
    name     = "<replace_with_unique_name_for_azurerm_resource_group>"
    location = "<replace_with_unique_name_azure_location"
  }
  storage_account = {
    name = "<replace_with_unique_name_for_storeage_account>"
  }
}

output "bucket_names" {
  value       = module.bucket.storage_container_name
  description = "List of bucket names created"
}
output "storage_account_name" {
  value       = module.bucket.storage_account_name
  description = "name of the storage account"
}
output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = module.bucket.storage_account_primary_access_key
  sensitive   = true
}
output "storage_account_primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = module.bucket.storage_account_primary_connection_string
  sensitive   = true
}
output "storage_account_secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = module.bucket.storage_account_secondary_access_key
  sensitive   = true
}
output "storage_account_secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = module.bucket.storage_account_secondary_connection_string
  sensitive   = true
}

```
Example:
```json
provider "azurerm" {
  # Configuration options
  features {
  }
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket"
  bucket_names = ["fake-bucket-name-1", "fake-bucket-name-2", "fake-bucket-name-3"]
  azurerm_resource_group = {
    name     = "telestream-cloud-port-dev-resource-group"
    location = "East US"
  }
  storage_account = {
    name = "tcaccount"
  }
}

output "bucket_names" {
  value       = module.bucket.storage_container_name
  description = "List of bucket names created"
}
output "storage_account_name" {
  value       = module.bucket.storage_account_name
  description = "name of the storage account"
}
output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = module.bucket.storage_account_primary_access_key
  sensitive   = true
}
output "storage_account_primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = module.bucket.storage_account_primary_connection_string
  sensitive   = true
}
output "storage_account_secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = module.bucket.storage_account_secondary_access_key
  sensitive   = true
}
output "storage_account_secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = module.bucket.storage_account_secondary_connection_string
  sensitive   = true
}

```
# Initialize the Directory
When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the AZURE provider. Terraform documentation can be found [here][terraform-init]
```sh
terraform init
```
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
# Terraform Plan
The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. The plan command alone does not actually carry out the proposed changes. You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review. Terraform documentation can be found [here][terraform-plan]
```sh
terraform plan
```
Example:
```sh
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.bucket.azurerm_resource_group.resource_group[0] will be created
  + resource "azurerm_resource_group" "resource_group" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "telestream-cloud-port-dev-resource-group"
    }

  # module.bucket.azurerm_storage_account.storage_account[0] will be created
  + resource "azurerm_storage_account" "storage_account" {
      + access_tier                       = (known after apply)
      + account_kind                      = "StorageV2"
      + account_replication_type          = "RAGRS"
      + account_tier                      = "Standard"
      + allow_nested_items_to_be_public   = true
      + cross_tenant_replication_enabled  = true
      + default_to_oauth_authentication   = false
      + enable_https_traffic_only         = true
      + id                                = (known after apply)
      + infrastructure_encryption_enabled = false
      + is_hns_enabled                    = false
      + large_file_share_enabled          = (known after apply)
      + location                          = "eastus"
      + min_tls_version                   = "TLS1_2"
      + name                              = "tcaccount"
      + nfsv3_enabled                     = false
      + primary_access_key                = (sensitive value)
      + primary_blob_connection_string    = (sensitive value)
      + primary_blob_endpoint             = (known after apply)
      + primary_blob_host                 = (known after apply)
      + primary_connection_string         = (sensitive value)
      + primary_dfs_endpoint              = (known after apply)
      + primary_dfs_host                  = (known after apply)
      + primary_file_endpoint             = (known after apply)
      + primary_file_host                 = (known after apply)
      + primary_location                  = (known after apply)
      + primary_queue_endpoint            = (known after apply)
      + primary_queue_host                = (known after apply)
      + primary_table_endpoint            = (known after apply)
      + primary_table_host                = (known after apply)
      + primary_web_endpoint              = (known after apply)
      + primary_web_host                  = (known after apply)
      + public_network_access_enabled     = true
      + queue_encryption_key_type         = "Service"
      + resource_group_name               = "telestream-cloud-port-dev-resource-group"
      + secondary_access_key              = (sensitive value)
      + secondary_blob_connection_string  = (sensitive value)
      + secondary_blob_endpoint           = (known after apply)
      + secondary_blob_host               = (known after apply)
      + secondary_connection_string       = (sensitive value)
      + secondary_dfs_endpoint            = (known after apply)
      + secondary_dfs_host                = (known after apply)
      + secondary_file_endpoint           = (known after apply)
      + secondary_file_host               = (known after apply)
      + secondary_location                = (known after apply)
      + secondary_queue_endpoint          = (known after apply)
      + secondary_queue_host              = (known after apply)
      + secondary_table_endpoint          = (known after apply)
      + secondary_table_host              = (known after apply)
      + secondary_web_endpoint            = (known after apply)
      + secondary_web_host                = (known after apply)
      + sftp_enabled                      = false
      + shared_access_key_enabled         = true
      + table_encryption_key_type         = "Service"

      + blob_properties {
          + change_feed_enabled           = (known after apply)
          + change_feed_retention_in_days = (known after apply)
          + default_service_version       = (known after apply)
          + last_access_time_enabled      = (known after apply)
          + versioning_enabled            = (known after apply)

          + container_delete_retention_policy {
              + days = (known after apply)
            }

          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }

          + restore_policy {
              + days = (known after apply)
            }
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)

          + private_link_access {
              + endpoint_resource_id = (known after apply)
              + endpoint_tenant_id   = (known after apply)
            }
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }

      + routing {
          + choice                      = (known after apply)
          + publish_internet_endpoints  = (known after apply)
          + publish_microsoft_endpoints = (known after apply)
        }

      + share_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + retention_policy {
              + days = (known after apply)
            }

          + smb {
              + authentication_types            = (known after apply)
              + channel_encryption_type         = (known after apply)
              + kerberos_ticket_encryption_type = (known after apply)
              + multichannel_enabled            = (known after apply)
              + versions                        = (known after apply)
            }
        }
    }

  # module.bucket.azurerm_storage_container.storage_container[0] will be created
  + resource "azurerm_storage_container" "storage_container" {
      + container_access_type   = "private"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "fake-bucket-name-1"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "tcaccount"
    }

  # module.bucket.azurerm_storage_container.storage_container[1] will be created
  + resource "azurerm_storage_container" "storage_container" {
      + container_access_type   = "private"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "fake-bucket-name-2"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "tcaccount"
    }

  # module.bucket.azurerm_storage_container.storage_container[2] will be created
  + resource "azurerm_storage_container" "storage_container" {
      + container_access_type   = "private"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "fake-bucket-name-3"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "tcaccount"
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_names                                = "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3"
  + storage_account_name                        = "tcaccount"
  + storage_account_primary_access_key          = (sensitive value)
  + storage_account_primary_connection_string   = (sensitive value)
  + storage_account_secondary_access_key        = (sensitive value)
  + storage_account_secondary_connection_string = (sensitive value)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
$ 
```
# Create Infrastructure
The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, enter yes to approve. After approval it will create infrastructure. Terraform documentation can be found [here][terraform-apply]
```sh
terraform apply
```
Example:
```sh
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.bucket.azurerm_resource_group.resource_group[0] will be created
  + resource "azurerm_resource_group" "resource_group" {
      + id       = (known after apply)
      + location = "eastus"
      + name     = "telestream-cloud-port-dev-resource-group"
    }

  # module.bucket.azurerm_storage_account.storage_account[0] will be created
  + resource "azurerm_storage_account" "storage_account" {
      + access_tier                       = (known after apply)
      + account_kind                      = "StorageV2"
      + account_replication_type          = "RAGRS"
      + account_tier                      = "Standard"
      + allow_nested_items_to_be_public   = true
      + cross_tenant_replication_enabled  = true
      + default_to_oauth_authentication   = false
      + enable_https_traffic_only         = true
      + id                                = (known after apply)
      + infrastructure_encryption_enabled = false
      + is_hns_enabled                    = false
      + large_file_share_enabled          = (known after apply)
      + location                          = "eastus"
      + min_tls_version                   = "TLS1_2"
      + name                              = "tcaccount"
      + nfsv3_enabled                     = false
      + primary_access_key                = (sensitive value)
      + primary_blob_connection_string    = (sensitive value)
      + primary_blob_endpoint             = (known after apply)
      + primary_blob_host                 = (known after apply)
      + primary_connection_string         = (sensitive value)
      + primary_dfs_endpoint              = (known after apply)
      + primary_dfs_host                  = (known after apply)
      + primary_file_endpoint             = (known after apply)
      + primary_file_host                 = (known after apply)
      + primary_location                  = (known after apply)
      + primary_queue_endpoint            = (known after apply)
      + primary_queue_host                = (known after apply)
      + primary_table_endpoint            = (known after apply)
      + primary_table_host                = (known after apply)
      + primary_web_endpoint              = (known after apply)
      + primary_web_host                  = (known after apply)
      + public_network_access_enabled     = true
      + queue_encryption_key_type         = "Service"
      + resource_group_name               = "telestream-cloud-port-dev-resource-group"
      + secondary_access_key              = (sensitive value)
      + secondary_blob_connection_string  = (sensitive value)
      + secondary_blob_endpoint           = (known after apply)
      + secondary_blob_host               = (known after apply)
      + secondary_connection_string       = (sensitive value)
      + secondary_dfs_endpoint            = (known after apply)
      + secondary_dfs_host                = (known after apply)
      + secondary_file_endpoint           = (known after apply)
      + secondary_file_host               = (known after apply)
      + secondary_location                = (known after apply)
      + secondary_queue_endpoint          = (known after apply)
      + secondary_queue_host              = (known after apply)
      + secondary_table_endpoint          = (known after apply)
      + secondary_table_host              = (known after apply)
      + secondary_web_endpoint            = (known after apply)
      + secondary_web_host                = (known after apply)
      + sftp_enabled                      = false
      + shared_access_key_enabled         = true
      + table_encryption_key_type         = "Service"

      + blob_properties {
          + change_feed_enabled           = (known after apply)
          + change_feed_retention_in_days = (known after apply)
          + default_service_version       = (known after apply)
          + last_access_time_enabled      = (known after apply)
          + versioning_enabled            = (known after apply)

          + container_delete_retention_policy {
              + days = (known after apply)
            }

          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + delete_retention_policy {
              + days = (known after apply)
            }

          + restore_policy {
              + days = (known after apply)
            }
        }

      + network_rules {
          + bypass                     = (known after apply)
          + default_action             = (known after apply)
          + ip_rules                   = (known after apply)
          + virtual_network_subnet_ids = (known after apply)

          + private_link_access {
              + endpoint_resource_id = (known after apply)
              + endpoint_tenant_id   = (known after apply)
            }
        }

      + queue_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + hour_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }

          + logging {
              + delete                = (known after apply)
              + read                  = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
              + write                 = (known after apply)
            }

          + minute_metrics {
              + enabled               = (known after apply)
              + include_apis          = (known after apply)
              + retention_policy_days = (known after apply)
              + version               = (known after apply)
            }
        }

      + routing {
          + choice                      = (known after apply)
          + publish_internet_endpoints  = (known after apply)
          + publish_microsoft_endpoints = (known after apply)
        }

      + share_properties {
          + cors_rule {
              + allowed_headers    = (known after apply)
              + allowed_methods    = (known after apply)
              + allowed_origins    = (known after apply)
              + exposed_headers    = (known after apply)
              + max_age_in_seconds = (known after apply)
            }

          + retention_policy {
              + days = (known after apply)
            }

          + smb {
              + authentication_types            = (known after apply)
              + channel_encryption_type         = (known after apply)
              + kerberos_ticket_encryption_type = (known after apply)
              + multichannel_enabled            = (known after apply)
              + versions                        = (known after apply)
            }
        }
    }

  # module.bucket.azurerm_storage_container.storage_container[0] will be created
  + resource "azurerm_storage_container" "storage_container" {
      + container_access_type   = "private"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "fake-bucket-name-1"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "tcaccount"
    }

  # module.bucket.azurerm_storage_container.storage_container[1] will be created
  + resource "azurerm_storage_container" "storage_container" {
      + container_access_type   = "private"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "fake-bucket-name-2"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "tcaccount"
    }

  # module.bucket.azurerm_storage_container.storage_container[2] will be created
  + resource "azurerm_storage_container" "storage_container" {
      + container_access_type   = "private"
      + has_immutability_policy = (known after apply)
      + has_legal_hold          = (known after apply)
      + id                      = (known after apply)
      + metadata                = (known after apply)
      + name                    = "fake-bucket-name-3"
      + resource_manager_id     = (known after apply)
      + storage_account_name    = "tcaccount"
    }

Plan: 5 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_names                                = "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3"
  + storage_account_name                        = "tcaccount"
  + storage_account_primary_access_key          = (sensitive value)
  + storage_account_primary_connection_string   = (sensitive value)
  + storage_account_secondary_access_key        = (sensitive value)
  + storage_account_secondary_connection_string = (sensitive value)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.bucket.azurerm_resource_group.resource_group[0]: Creating...
module.bucket.azurerm_resource_group.resource_group[0]: Creation complete after 1s [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]
module.bucket.azurerm_storage_account.storage_account[0]: Creating...
module.bucket.azurerm_storage_account.storage_account[0]: Still creating... [10s elapsed]
module.bucket.azurerm_storage_account.storage_account[0]: Still creating... [20s elapsed]
module.bucket.azurerm_storage_account.storage_account[0]: Creation complete after 23s [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]
module.bucket.azurerm_storage_container.storage_container[0]: Creating...
module.bucket.azurerm_storage_container.storage_container[1]: Creating...
module.bucket.azurerm_storage_container.storage_container[2]: Creating...
module.bucket.azurerm_storage_container.storage_container[2]: Creation complete after 0s [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3]
module.bucket.azurerm_storage_container.storage_container[1]: Creation complete after 0s [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2]
module.bucket.azurerm_storage_container.storage_container[0]: Creation complete after 0s [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1]

Apply complete! Resources: 5 added, 0 changed, 0 destroyed.

Outputs:

bucket_names = "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3"
storage_account_name = "tcaccount"
storage_account_primary_access_key = <sensitive>
storage_account_primary_connection_string = <sensitive>
storage_account_secondary_access_key = <sensitive>
storage_account_secondary_connection_string = <sensitive>
$ 
```