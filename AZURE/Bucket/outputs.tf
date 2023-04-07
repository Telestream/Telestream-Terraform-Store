// resouce group id
output "azurerm_resource_group_id" {
  value       = join("", azurerm_resource_group.resource_group.*.id)
  description = "The ID of the Resource Group."
}
output "azurerm_resource_group_name" {
  value       = join("", azurerm_resource_group.resource_group.*.name)
  description = "The Name of the Resource Group."
}
output "azurerm_resource_group_location" {
  value       = join("", azurerm_resource_group.resource_group.*.location)
  description = "The Azure Region where the Resource Group should exist."
}

// existing_resource_group_name
output "existing_resource_group_name" {
  value       = join("", data.azurerm_resource_group.resource_group.*.name)
  description = "The Name of the Resource Group."
}
output "existing_resource_group_location" {
  value       = join("", data.azurerm_resource_group.resource_group.*.location)
  description = "The Azure Region where the existing Resource Group."
}

//azurerm_storage_account
output "storage_account_id" {
  description = "The ID of the Storage Account."
  value       = join("", azurerm_storage_account.storage_account.*.id)
}
output "storage_account_primary_location" {
  description = "The primary location of the storage account."
  value       = join("", azurerm_storage_account.storage_account.*.primary_location)
}
output "storage_account_secondary_location" {
  description = "The secondary location of the storage account."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_location)
}
output "storage_account_primary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_blob_endpoint)
}
output "storage_account_primary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_blob_host)
}
output "storage_account_secondary_blob_endpoint" {
  description = "The endpoint URL for blob storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_blob_endpoint)
}
output "storage_account_secondary_blob_host" {
  description = "The hostname with port if applicable for blob storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_blob_host)
}
output "storage_account_primary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_queue_endpoint)
}
output "storage_account_primary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_queue_host)
}
output "storage_account_secondary_queue_endpoint" {
  description = "The endpoint URL for queue storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_queue_endpoint)
}
output "storage_account_secondary_queue_host" {
  description = "The hostname with port if applicable for queue storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_queue_host)
}
output "storage_account_primary_table_endpoint" {
  description = "The endpoint URL for table storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_table_endpoint)
}
output "storage_account_primary_table_host" {
  description = "The hostname with port if applicable for table storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_table_host)
}
output "storage_account_secondary_table_endpoint" {
  description = "The endpoint URL for table storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_table_endpoint)
}
output "storage_account_secondary_table_host" {
  description = "The hostname with port if applicable for table storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_table_host)
}
output "storage_account_primary_file_endpoint" {
  description = "The endpoint URL for file storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_file_endpoint)
}
output "storage_account_primary_file_host" {
  description = "The hostname with port if applicable for file storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_file_host)
}
output "storage_account_secondary_file_endpoint" {
  description = "The endpoint URL for file storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_file_endpoint)
}
output "storage_account_secondary_file_host" {
  description = "The hostname with port if applicable for file storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_file_host)
}
output "storage_account_primary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_dfs_endpoint)
}
output "storage_account_primary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_dfs_host)
}
output "storage_account_secondary_dfs_endpoint" {
  description = "The endpoint URL for DFS storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_dfs_endpoint)
}
output "storage_account_secondary_dfs_host" {
  description = "The hostname with port if applicable for DFS storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_dfs_host)
}
output "storage_account_primary_web_endpoint" {
  description = "The endpoint URL for web storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_web_endpoint)
}
output "storage_account_primary_web_host" {
  description = "The hostname with port if applicable for web storage in the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_web_host)
}
output "storage_account_secondary_web_endpoint" {
  description = "The endpoint URL for web storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_web_endpoint)
}
output "storage_account_secondary_web_host" {
  description = "The hostname with port if applicable for web storage in the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_web_host)
}
output "storage_account_identity" {
  description = "An identity block."
  value       = azurerm_storage_account.storage_account.*.identity
}
output "storage_account_name" {
  description = "Specifies the name of the storage account."
  value       = join("", azurerm_storage_account.storage_account.*.name)
}
output "storage_account_resource_group_name" {
  description = "The name of the resource group in which to create the storage account"
  value       = join("", azurerm_storage_account.storage_account.*.resource_group_name)
}
output "storage_account_location" {
  description = "Specifies the supported Azure location where the resource exists"
  value       = join("", azurerm_storage_account.storage_account.*.location)
}
output "storage_account_account_kind" {
  description = "Defines the Kind of account"
  value       = join("", azurerm_storage_account.storage_account.*.account_kind)
}
output "storage_account_account_tier" {
  description = "Defines the Tier to use for this storage account"
  value       = join("", azurerm_storage_account.storage_account.*.account_tier)
}
output "storage_account_account_replication_type" {
  description = "Defines the type of replication to use for this storage account"
  value       = join("", azurerm_storage_account.storage_account.*.account_replication_type)
}
output "storage_account_access_tier" {
  description = "Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts"
  value       = join("", azurerm_storage_account.storage_account.*.access_tier)
}
output "storage_account_primary_access_key" {
  description = "The primary access key for the storage account."
  value       = join("", azurerm_storage_account.storage_account.*.primary_access_key)
  sensitive   = true
}
output "storage_account_primary_connection_string" {
  description = "The connection string associated with the primary location."
  value       = join("", azurerm_storage_account.storage_account.*.primary_connection_string)
  sensitive   = true
}
output "storage_account_secondary_access_key" {
  description = "The secondary access key for the storage account."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_access_key)
  sensitive   = true
}
output "storage_account_secondary_connection_string" {
  description = "The connection string associated with the secondary location."
  value       = join("", azurerm_storage_account.storage_account.*.secondary_connection_string)
  sensitive   = true
}

//azurerm_storage_container
output "storage_container_name" {
  value       = join(",", azurerm_storage_container.storage_container.*.name)
  description = "The name of the Container which created within the Storage Account"
}
output "storage_container_storage_account_name" {
  value       = join(",", azurerm_storage_container.storage_container.*.storage_account_name)
  description = "The name of the Storage Account where the Container is created in"
}
output "storage_container_container_access_type" {
  value       = join(",", azurerm_storage_container.storage_container.*.container_access_type)
  description = "he Access Level configured for this Container."
}
output "storage_container_metadata" {
  value       = azurerm_storage_container.storage_container.*.metadata
  description = "A mapping of MetaData for this Container."
}
output "storage_container_id" {
  value       = join(",", azurerm_storage_container.storage_container.*.id)
  description = "The ID of the Storage Container."
}
output "storage_container_has_immutability_policy" {
  value       = join(",", azurerm_storage_container.storage_container.*.has_immutability_policy)
  description = "Is there an Immutability Policy configured on this Storage Container"
}
output "storage_container_has_legal_hold" {
  value       = join(",", azurerm_storage_container.storage_container.*.has_legal_hold)
  description = " Is there a Legal Hold configured on this Storage Container"
}
output "storage_container_resource_manager_id" {
  value       = join(",", azurerm_storage_container.storage_container.*.resource_manager_id)
  description = "The Resource Manager ID of this Storage Container."
}
