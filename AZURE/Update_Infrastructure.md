# How to Update Infrastructure AZURE
# NOTE if changing the bucket names, terraform will attempt to delete the existing buckets and all objects inside, so be careful and read terraform plan on what will be destroyed

Terraform Build Infrastructure Documentation can be found [here](https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build)

# Table of Contents
1. [Requirements](README.md)
3. [Update values in module](#update-values-in-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

<br />

Go into the directory with the `main.tf` and `terraform.tfstate` to run the terraform destroy command.

## Update values in module

To update values after deployed, just change values in main.tf to new values you want. Example changing the policy, role name, or bucket names. Changing bucket name will have terraform destroy old buckets and everything in it and create a new bucket, this will result of losing all objects in the s3 bucket. 

<br /> 
Example bellow will update the bucket names.

Original:

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



<br />

Update:

```json
provider "azurerm" {
  # Configuration options
  features {
  }
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket"
  bucket_names = ["fake-bucket-name-1-new", "fake-bucket-name-2-new", "fake-bucket-name-3-new"]
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

## Terraform Plan

The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. The plan command alone does not actually carry out the proposed changes. You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/plan)

```sh
terraform plan
```



<br />

Example:

```sh
$ terraform plan
module.bucket.azurerm_resource_group.resource_group[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]
module.bucket.azurerm_storage_account.storage_account[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]
module.bucket.azurerm_storage_container.storage_container[0]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1]
module.bucket.azurerm_storage_container.storage_container[2]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3]
module.bucket.azurerm_storage_container.storage_container[1]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.bucket.azurerm_storage_account.storage_account[0] has changed
  ~ resource "azurerm_storage_account" "storage_account" {
        id                                = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount"
        name                              = "tcaccount"
      + tags                              = {}
        # (49 unchanged attributes hidden)

        # (4 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.bucket.azurerm_storage_container.storage_container[0] must be replaced
-/+ resource "azurerm_storage_container" "storage_container" {
      ~ has_immutability_policy = false -> (known after apply)
      ~ has_legal_hold          = false -> (known after apply)
      ~ id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-1" -> (known after apply)
      ~ metadata                = {} -> (known after apply)
      ~ name                    = "fake-bucket-name-1" -> "fake-bucket-name-1-new" # forces replacement
      ~ resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-1" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

  # module.bucket.azurerm_storage_container.storage_container[1] must be replaced
-/+ resource "azurerm_storage_container" "storage_container" {
      ~ has_immutability_policy = false -> (known after apply)
      ~ has_legal_hold          = false -> (known after apply)
      ~ id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-2" -> (known after apply)
      ~ metadata                = {} -> (known after apply)
      ~ name                    = "fake-bucket-name-2" -> "fake-bucket-name-2-new" # forces replacement
      ~ resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-2" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

  # module.bucket.azurerm_storage_container.storage_container[2] must be replaced
-/+ resource "azurerm_storage_container" "storage_container" {
      ~ has_immutability_policy = false -> (known after apply)
      ~ has_legal_hold          = false -> (known after apply)
      ~ id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-3" -> (known after apply)
      ~ metadata                = {} -> (known after apply)
      ~ name                    = "fake-bucket-name-3" -> "fake-bucket-name-3-new" # forces replacement
      ~ resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-3" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

Plan: 3 to add, 0 to change, 3 to destroy.

Changes to Outputs:
  ~ bucket_names = "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3" -> "fake-bucket-name-1-new,fake-bucket-name-2-new,fake-bucket-name-3-new"

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
$
```



<br />

## Create Infrastructure

The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, enter yes to approve. After approval it will create infrastructure. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/apply)

```sh
terraform apply
```



<br />

Example:

```sh
$ terraform apply
module.bucket.azurerm_resource_group.resource_group[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group]
module.bucket.azurerm_storage_account.storage_account[0]: Refreshing state... [id=/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount]
module.bucket.azurerm_storage_container.storage_container[2]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3]
module.bucket.azurerm_storage_container.storage_container[1]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2]
module.bucket.azurerm_storage_container.storage_container[0]: Refreshing state... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.bucket.azurerm_storage_account.storage_account[0] has changed
  ~ resource "azurerm_storage_account" "storage_account" {
        id                                = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount"
        name                              = "tcaccount"
      + tags                              = {}
        # (49 unchanged attributes hidden)

        # (4 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.bucket.azurerm_storage_container.storage_container[0] must be replaced
-/+ resource "azurerm_storage_container" "storage_container" {
      ~ has_immutability_policy = false -> (known after apply)
      ~ has_legal_hold          = false -> (known after apply)
      ~ id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-1" -> (known after apply)
      ~ metadata                = {} -> (known after apply)
      ~ name                    = "fake-bucket-name-1" -> "fake-bucket-name-1-new" # forces replacement
      ~ resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-1" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

  # module.bucket.azurerm_storage_container.storage_container[1] must be replaced
-/+ resource "azurerm_storage_container" "storage_container" {
      ~ has_immutability_policy = false -> (known after apply)
      ~ has_legal_hold          = false -> (known after apply)
      ~ id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-2" -> (known after apply)
      ~ metadata                = {} -> (known after apply)
      ~ name                    = "fake-bucket-name-2" -> "fake-bucket-name-2-new" # forces replacement
      ~ resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-2" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

  # module.bucket.azurerm_storage_container.storage_container[2] must be replaced
-/+ resource "azurerm_storage_container" "storage_container" {
      ~ has_immutability_policy = false -> (known after apply)
      ~ has_legal_hold          = false -> (known after apply)
      ~ id                      = "https://tcaccount.blob.core.windows.net/fake-bucket-name-3" -> (known after apply)
      ~ metadata                = {} -> (known after apply)
      ~ name                    = "fake-bucket-name-3" -> "fake-bucket-name-3-new" # forces replacement
      ~ resource_manager_id     = "/subscriptions/df95b436-de1f-4c2a-96d9-b4801b1e2209/resourceGroups/telestream-cloud-port-dev-resource-group/providers/Microsoft.Storage/storageAccounts/tcaccount/blobServices/default/containers/fake-bucket-name-3" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

Plan: 3 to add, 0 to change, 3 to destroy.

Changes to Outputs:
  ~ bucket_names = "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3" -> "fake-bucket-name-1-new,fake-bucket-name-2-new,fake-bucket-name-3-new"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.bucket.azurerm_storage_container.storage_container[2]: Destroying... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3]
module.bucket.azurerm_storage_container.storage_container[0]: Destroying... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1]
module.bucket.azurerm_storage_container.storage_container[1]: Destroying... [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2]
module.bucket.azurerm_storage_container.storage_container[2]: Destruction complete after 2s
module.bucket.azurerm_storage_container.storage_container[2]: Creating...
module.bucket.azurerm_storage_container.storage_container[0]: Destruction complete after 2s
module.bucket.azurerm_storage_container.storage_container[0]: Creating...
module.bucket.azurerm_storage_container.storage_container[1]: Destruction complete after 2s
module.bucket.azurerm_storage_container.storage_container[1]: Creating...
module.bucket.azurerm_storage_container.storage_container[2]: Creation complete after 1s [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-3-new]
module.bucket.azurerm_storage_container.storage_container[0]: Creation complete after 1s [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-1-new]
module.bucket.azurerm_storage_container.storage_container[1]: Creation complete after 1s [id=https://tcaccount.blob.core.windows.net/fake-bucket-name-2-new]

Apply complete! Resources: 3 added, 0 changed, 3 destroyed.

Outputs:

bucket_names = "fake-bucket-name-1-new,fake-bucket-name-2-new,fake-bucket-name-3-new"
storage_account_name = "tcaccount"
storage_account_primary_access_key = <sensitive>
storage_account_primary_connection_string = <sensitive>
storage_account_secondary_access_key = <sensitive>
storage_account_secondary_connection_string = <sensitive>
$
```