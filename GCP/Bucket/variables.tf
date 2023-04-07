// bucket settings
variable "enabled" {
  default     = true
  type        = bool
  description = "(Optional) default true creates the GCP bucket if false does not create any resources"
  nullable    = false
}
variable "project" {
  type        = string
  default     = null
  description = "(Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used."
}

variable "bucket_names" {
  description = "The list of names for the buckets. Must be lowercase and must be between 3 (min) and 63 (max) characters long, go to link for bucket name rules https://cloud.google.com/storage/docs/buckets#:~:text=by%2Dstep%20guide.-,Bucket%20names,Spaces%20are%20not%20allowed."
  type        = list(string)
  default     = []
  nullable = false
  //Bucket names can only contain lowercase letters, numeric characters, dashes (-), underscores (_), and dots (.). Spaces are not allowed. Names containing dots require verification.
  validation {
      condition     = alltrue([for bucket_name in var.bucket_names : can(regex("^[0-9a-z._-]*$", bucket_name))])
      error_message = "Bucket names can only contain lowercase letters, numeric characters, dashes (-), underscores (_), and dots (.). Spaces are not allowed. Names containing dots require verification(https://cloud.google.com/storage/docs/domain-name-verification)."
  }
  validation {
      condition     = alltrue([for bucket_name in var.bucket_names :  bucket_name == null || can(regex("^[a-z0-9].*[a-z0-9]$|^$", bucket_name))])
      error_message = "Bucket names must start and end with a number or letter."
  }
  validation {
    // break up string by . and check if each index is less then 63 characters
      condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || bucket_name == "" ? true:  alltrue([for bucket_name_dot in split(".",bucket_name) :length(bucket_name_dot) >= 3 && length(bucket_name_dot) <= 63]) ])  
      error_message = "Bucket names must contain 3-63 characters. Names containing dots can contain up to 222 characters, but each dot-separated component can be no longer than 63 characters."
  }
  validation {
      condition     = alltrue([for bucket_name in var.bucket_names :  bucket_name == null || !can(regex("^(?:(?:[0-9]{1,63})\\.){3}(?:[0-9]{1,63})$", bucket_name))])
      error_message = "Bucket names cannot be represented as an IP address in dotted-decimal notation (for example, 192.168.5.4)."
  }
  validation {
      condition     = alltrue([for bucket_name in var.bucket_names :  bucket_name == null || !can(regex("^goog*", bucket_name))])
      error_message = "Bucket names cannot begin with the 'goog' prefix."
  }
  validation {
      condition     = alltrue([for bucket_name in var.bucket_names :  bucket_name == null || can(contains(["google", "g00gle","g00g13"], lower(bucket_name)))])
      error_message = "Bucket names cannot contain 'google' or close misspellings, such as 'g00gle'."
  }
}

variable "public_access_prevention" {
  type        = string
  nullable    = false
  default     = "enforced"
  description = "(Optional, default enforced) Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention. only if the bucket is subject to the public access prevention organization policy constraint"
    validation {
    condition     = can(contains(["inherited", "enforced",], var.public_access_prevention))
    error_message = "Acceptable values are inherited or enforced"
  }
}
variable "uniform_bucket_level_access" {
  type        = bool
  nullable    = false
  default     = false
  description = "(Optional, Default: false) Enables Uniform bucket-level access access to a bucket, false sets bucket to Fine-grained for access control which is required by telestream"
  validation {
    condition     = !var.uniform_bucket_level_access
    error_message = "Needs to be set to false, which is default value"
  }
}

variable "force_destroy" {
  type        = bool
  default     = false
  description = "(Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run."
}

variable "bucket_location" {
  type        = string
  nullable    = false
  description = "(Required) The GCS location(https://cloud.google.com/storage/docs/locations)."
}

variable "storage_class" {
  description = "(Optional, Default: 'STANDARD') The Storage Class of the new bucket. Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  type = string
  default = "STANDARD"
  validation {
    condition     = can(contains(["STANDARD", "MULTI_REGIONAL", "REGIONAL", "NEARLINE", "COLDLINE", "ARCHIVE"], var.storage_class))
    error_message = " Supported values include: STANDARD, MULTI_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE."
  }
}
//
variable "service_account" {
      type = object({
        create_service_account      = optional(bool, true)
        create_service_account_key  = optional(bool, true)
        //google_service_account
        account_id                  = optional(string)
        display_name                = optional(string)
        description                 = optional(string,"Service Account used to allow telestream cloud access the azure buckets")
        disabled                    = optional(bool,false)
        //google_storage_hmac_key
        key_state                   = optional(string, "ACTIVE")
      })
      nullable = false
          description = <<EOT
        service_account_account = {
          create_service_account      :"(Optional, Default true) if set to true will create a service account that has access to buckets created"
          create_service_account_key  :"(Optional, Default true) If set to true will create keys that telestream can use to access bucket"
          account_id                  :"(Required) The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression [a-z]([-a-z0-9]*[a-z0-9]) to comply with RFC1035. Changing this forces a new service account to be created."
          display_name                :"(Optional) The display name for the service account. Can be updated without creating a new resource."
          description                 :"(Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."
          disabled                    :"(Optional, default false) Whether a service account is disabled or not. Defaults to false. This field has no effect during creation. Must be set after creation to disable a service account."
          key_state                   :"(Optional, default ACTIVE) The state of the key. Can be set to one of ACTIVE, INACTIVE. Default value is ACTIVE. Possible values are ACTIVE and INACTIVE."
        }
    EOT
    validation {
        condition     = var.service_account.create_service_account == true ? length(var.service_account.account_id) >= 6 && length(var.service_account.account_id) <= 30 : true
        error_message = "account_id must be 6-30 characters long"
    }
    validation {
        condition     = var.service_account.create_service_account == true ? can(regex("^[-a-z0-9]*$", var.service_account.account_id)) : true
        error_message = "account_id only contain lowercase letters, numeric characters, dashes (-)"
    }
    validation {
        condition     = var.service_account.create_service_account == true ? can(regex("^[a-z].*[a-z0-9]$|^$", var.service_account.account_id) ) : true
        error_message = "account_id must start letter and end with a number or letter."
    }
    validation {
        condition     = contains(["ACTIVE", "INACTIVE"], var.service_account.key_state)
        error_message = "Possible values are ACTIVE and INACTIVE."
    }
}
