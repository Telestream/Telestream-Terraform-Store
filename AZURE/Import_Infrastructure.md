# How to Import Current Infrastructure AZURE


# Table of Contents
1. [Requirements](README.md)
2. [Initialize the Directory](#initialize-the-directory)
3. [Update Terraform Module to use Existing Resource Name to be Imported](#update-terraform-module-to-use-existing-resource-name-to-be-imported)
4. [How to Import Storage container](#how-to-import-storage-container)
6. [How to Import Resource Group](#how-to-import-resource-group)
7. [How to Import Storage Account](#how-to-import-storage-account)

<br />

Go into the directory with the `main.tf`

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

## Update Terraform Module to use Existing Resource Name to be Imported

Copy the module in [Examples](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AZURE/Examples) directory that fits your requirements. Example module in examples will be the  [Create_Storage_Containers_And_Resource_Group](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AZURE/Examples/Create_Storage_Containers_And_Resource_Group) module

For all resources that you want to import to be controlled by terraform, update the `main.tf` file with their existing names instead of new unique names.

```json
provider "azurerm" {
  # Configuration options
  features {
  }
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket"
  bucket_names = ["<replace_with_existing_name_of_buckets>"]
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



<br />

Example

```json
provider "azurerm" {
  # Configuration options
  features {
  }
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket"
  bucket_names = ["fake-bucket-name"]
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



<br />

## Terraform Import

Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/import) This is done by using the command terraform import

## How to Import Storage container

- Storage Containers can be imported using the resource id

```sh
terraform import  module.bucket.azurerm_storage_container.storage_container[0] <storage_container_resouce_id>
```



Example

```sh
$ terraform import  module.bucket.azurerm_storage_container.storage_container[0] https://tcaccount.blob.core.windows.net/fake-bucket-name
module.bucket.azurerm_storage_container.storage_container[0]: Importing from ID "https://tcaccount.blob.core.windows.net/fake-bucket-name"...
module.bucket.azurerm_storage_container.storage_container[0]: Import prepared!
  Prepared azurerm_storage_container for import
module.bucket.azurerm_storage_container.storage_container[0]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
```



<br />

## How to Import Resource Group

Resource Groups can be imported using the resource id

```sh
terraform import module.bucket.azurerm_resource_group.resource_group[0] <resource_group_resouce_id>
```



Example

```sh
$ terraform import module.bucket.azurerm_resource_group.resource_group[0] /subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group
module.bucket.azurerm_resource_group.resource_group[0]: Importing from ID "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group"...
module.bucket.azurerm_resource_group.resource_group[0]: Import prepared!
  Prepared azurerm_resource_group for import
module.bucket.azurerm_resource_group.resource_group[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
```



<br />

## How to Import Storage Account

- Storage Accounts can be imported using the resource id

```sh
terraform import module.bucket.azurerm_storage_account.storage_account[0] <storage_account_resource_id>
```



Example

```sh
$ terraform import module.bucket.azurerm_storage_account.storage_account[0] /subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount

module.bucket.azurerm_storage_account.storage_account[0]: Importing from ID "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount"...
module.bucket.azurerm_storage_account.storage_account[0]: Import prepared!
  Prepared azurerm_storage_account for import
module.bucket.azurerm_storage_account.storage_account[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$
```



<br />

## Terraform Apply

The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes. After approval it will create infrastructure. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/apply)

```sh
terraform apply
```
```sh
$ terraform apply
module.bucket.azurerm_resource_group.resource_group[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]
module.bucket.azurerm_storage_account.storage_account[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]
module.bucket.azurerm_storage_container.storage_container[0]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

bucket_names = "fake-bucket-name"
storage_account_name = "tcaccount"
storage_account_primary_access_key = <sensitive>
storage_account_primary_connection_string = <sensitive>
storage_account_secondary_access_key = <sensitive>
storage_account_secondary_connection_string = <sensitive>
$ 
```