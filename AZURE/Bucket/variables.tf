// bucket settings
variable "enabled" {
  default     = true
  type        = bool
  description = "(Optional) default true creates the s3 bucket if false does not create any resources"
  nullable    = false
}

// azure resource group 
variable "azurerm_resource_group" {
  type = object({
    name                         = optional(string)
    location                     = optional(string)
    tags                         = optional(map(string))
    create_new                   = optional(string, true)
    existing_resource_group_name = optional(string)
  })
  default = {
    enabled = false
  }
  nullable    = false
  description = <<EOT
        azurerm_resource_group = {
            location                        : "(Required) The Azure Region where the Resource Group should exist. Changing this forces a new Resource Group to be created."
            name                            : "(Required) The Name which should be used for this Resource Group. Changing this forces a new Resource Group to be created."
            tags                            : "(Optional) A mapping of tags which should be assigned to the Resource Group"
            create_new                      : "(Optional) A flag to determine if creating a new Resource Group or an existing one that is not managed by this terraform module"
            existing_resource_group_name    : "(Required if create new is false) Specifies the name of your existing resource group."
        }
    EOT
  validation {
    condition     = var.azurerm_resource_group.create_new || var.azurerm_resource_group.existing_resource_group_name != null
    error_message = "if not creating a new resouce group, then the existing_resource_group_name must be provided that you wish to use"
  }
}

variable "storage_container" {
  type = object({
    container_access_type = optional(string, "private")
    metadata              = optional(map(string))
  })
  nullable    = false
  default     = {}
  description = <<EOT
        storage_container = {
          container_access_type : "(Optional) The Access Level configured for this Container. Possible values are blob, container or private. Defaults to private."
          metadata              : "(Optional) A mapping of MetaData for this Container. All metadata keys should be lowercase."
        }
    EOT
  validation {
    condition     = contains(["container", "private", "blob"], var.storage_container.container_access_type)
    error_message = "Possible values are blob, container or private. Defaults to private."
  }
}

variable "bucket_names" {
  description = "The list of name for the buckets"
  type        = list(string)
  default     = []
  nullable    = false
}

variable "storage_account" {
  type = object({
    name                     = optional(string)
    account_tier             = optional(string, "Standard")
    account_replication_type = optional(string, "RAGRS")
    tags                     = optional(map(string))
    account_kind             = optional(string, "StorageV2")
  })
  nullable = false
  default = {

  }
  description = <<EOT
        storage_account = {
          name                      : "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
          account_tier              : "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
          account_replication_type  : "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
          account_kind              : "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
          tags                      : "(Optional) A mapping of tags to assign to the resource."
        }
    EOT

}

