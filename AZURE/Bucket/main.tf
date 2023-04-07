locals {
  create_new_resource_group = var.enabled && var.azurerm_resource_group.create_new
}
// create storage account
resource "azurerm_resource_group" "resource_group" {
  count    = local.create_new_resource_group ? 1 : 0
  name     = var.azurerm_resource_group.name
  location = var.azurerm_resource_group.location
  tags     = var.azurerm_resource_group.tags
}
data "azurerm_resource_group" "resource_group" {
  count = local.create_new_resource_group ? 0 : 1
  name  = var.azurerm_resource_group.existing_resource_group_name
}

resource "azurerm_storage_account" "storage_account" {
  count                    = var.enabled ? 1 : 0
  name                     = var.storage_account.name
  resource_group_name      = local.create_new_resource_group ? join("", azurerm_resource_group.resource_group.*.name) : join("", data.azurerm_resource_group.resource_group.*.name)
  location                 = local.create_new_resource_group ? join("", azurerm_resource_group.resource_group.*.location) : join("", data.azurerm_resource_group.resource_group.*.location)
  account_tier             = var.storage_account.account_tier
  account_replication_type = var.storage_account.account_replication_type
  tags                     = var.storage_account.tags
}
// create a container
resource "azurerm_storage_container" "storage_container" {
  count                 = var.enabled ? length(var.bucket_names) : 0
  name                  = var.bucket_names[count.index]
  storage_account_name  = join("", azurerm_storage_account.storage_account.*.name)
  container_access_type = var.storage_container.container_access_type
  metadata              = var.storage_container.metadata
}
