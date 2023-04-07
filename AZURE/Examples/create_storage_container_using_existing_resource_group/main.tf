provider "azurerm" {
  # Configuration options
  features {
  }
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AZURE/Bucket"
  bucket_names = ["<replace_with_unique_name_of_bucket>"]
  azurerm_resource_group = {
    name       = "<replace_with_existing_name_for_azurerm_resource_group>"
    create_new = false
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
