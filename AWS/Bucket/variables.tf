
// bucket settings
variable "enabled" {
  default     = true
  type        = bool
  description = "(Optional) default true creates the s3 bucket if false does not create any resources"
  nullable    = false
}

variable "bucket_names" {
  description = "The list of name for the buckets. Must be lowercase and must be between 3 (min) and 63 (max) characters long, name rules based on https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  type        = list(string)
  default     = []
  // validation rules based on https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || bucket_name == "" ? true : length(bucket_name) >= 3 && length(bucket_name) <= 63])
    error_message = "Bucket Name must be between 3 (min) and 63 (max) characters long."
  }
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || can(regex("^[0-9a-z.-]*$", bucket_name))])
    error_message = "Bucket Name can consist only of lowercase letters, numbers, dots (.), and hyphens (-). Or Value can be null."
  }
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || can(regex("^[a-z0-9].*[a-z0-9]$|^$", bucket_name))])
    error_message = "Bucket Name must begin and end with a letter or number if it is not an empty string."
  }
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || !can(regex("[.]{2,}", bucket_name))])
    error_message = "Bucket names must not contain two adjacent periods."
  }
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || !can(regex("^(?:(?:[0-9]{1,63})\\.){3}(?:[0-9]{1,63})$", bucket_name))])
    error_message = "Bucket names must not be formatted as an IP address (for example, 192.168.5.4 or even invalid ip address like 9999.00000.12344567.123456789)."
  }
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || !can(regex("^xn--.*", bucket_name))])
    error_message = "Bucket Name must not start with the prefix xn--."
  }
  validation {
    condition     = alltrue([for bucket_name in var.bucket_names : bucket_name == null || !can(regex(".*-s3alias$", bucket_name))])
    error_message = "Bucket names must not end with the suffix -s3alias. This suffix is reserved for access point alias names."
  }
  nullable = false
}

variable "bucket_tags" {
  description = "Key-value map of tags for the Bucket"
  type        = map(string)
  default     = {}
}

variable "bucket_prefix" {
  description = "(Optional, Forces new resource) Creates a unique bucket name beginning with the specified prefix. Conflicts with bucket. Must be lowercase and less than or equal to 37 characters in length. A full list of bucket naming rules may be found here https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html"
  default     = null
  type        = string
  validation {
    condition     = var.bucket_prefix == null ? true : length(var.bucket_prefix) <= 37
    error_message = "Bucket Prefix must less than or equal to 37 characters in length"
  }
  validation {
    condition     = var.bucket_prefix == null || can(regex("^[0-9a-z.-]*$", var.bucket_prefix))
    error_message = "Bucket Prefix can consist only of lowercase letters, numbers, dots (.), and hyphens (-). Or Value can be null."
  }
  validation {
    condition     = var.bucket_prefix == null || can(regex("^[a-z0-9].*|^$", var.bucket_prefix))
    error_message = "Bucket Prefix must begin with a letter or number if it is not an empty string."
  }
  validation {
    condition     = var.bucket_prefix == null || !can(regex("[.]{2,}", var.bucket_prefix))
    error_message = "Bucket Prefix must not contain two adjacent periods."
  }
  validation {
    condition     = var.bucket_prefix == null || !can(regex("^(?:(?:[0-9]{1,63})\\.){3}(?:[0-9]{1,63})$", var.bucket_prefix))
    error_message = "Bucket Prefix must not be formatted as an IP address (for example, 192.168.5.4 or even invalid ip address like 9999.00000.12344567.123456789)."
  }
  validation {
    condition     = var.bucket_prefix == null || !can(regex("^xn--.*", var.bucket_prefix))
    error_message = "Bucket Prefix must not start with the prefix xn--."
  }

}

variable "force_destroy" {
  description = "(Optional, Default:false) Boolean that indicates all objects (including any locked objects) should be deleted from the bucket when the bucket is destroyed so that the bucket can be destroyed without error, when set to false need to manualy delete files in bucket before destroying bucket. These objects are not recoverable. This only deletes objects when the bucket is destroyed, not when setting this parameter to true. Once this parameter is set to true, there must be a successful terraform apply run before a destroy is required to update this value in the resource state. Without a successful terraform apply after this parameter is set, this flag will have no effect. If setting this field in the same operation that would require replacing the bucket or destroying the bucket, this flag will not work. Additionally when importing a bucket, a successful terraform apply is required to set this value in state before it will take effect on a destroy operation."
  default     = false
  type        = bool
  nullable    = false
}

// public access by default have all public access blocked
variable "block_public_acls" {
  description = "(Optional, Default:true) Whether Amazon S3 should block public ACLs for this bucket. Defaults to true. Enabling this setting does not affect existing policies or ACLs. When set to true causes the following behavior: PUT Bucket acl and PUT Object acl calls will fail if the specified ACL allows public access. PUT Object calls will fail if the request includes an object ACL."
  default     = true
  type        = bool
  nullable    = false
}
variable "block_public_policy" {
  description = "(Optional, Default:true) Whether Amazon S3 should block public bucket policies for this bucket. Defaults to true. Enabling this setting does not affect the existing bucket policy. When set to true causes Amazon S3 to: Reject calls to PUT Bucket policy if the specified bucket policy allows public access."
  default     = true
  type        = bool
  nullable    = false
}
variable "restrict_public_buckets" {
  description = "(Optional, Default:true) Whether Amazon S3 should ignore public ACLs for this bucket. Defaults to true. Enabling this setting does not affect the persistence of any existing ACLs and doesn't prevent new public ACLs from being set. When set to true causes Amazon S3 to: Ignore public ACLs on this bucket and any objects that it contains."
  default     = true
  type        = bool
  nullable    = false
}
variable "ignore_public_acls" {
  description = "(Optional, Default:true) Whether Amazon S3 should restrict public bucket policies for this bucket. Defaults to true. Enabling this setting does not affect the previously stored bucket policy, except that public and cross-account access within the public bucket policy, including non-public delegation to specific accounts, is blocked. When set to true: Only the bucket owner and AWS Services can access this buckets if it has a public policy."
  default     = true
  type        = bool
  nullable    = false
}


// assume policy for role
variable "assume_role_statements" {
  type = list(object({
    actions               = optional(list(string))
    sid                   = optional(string)
    effect                = optional(string)
    principal_type        = optional(string)
    principal_identifiers = optional(list(string))
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = list(string)
    })))
  }))
  // default allow telestream to assume role
  default = [{
    actions               = ["sts:AssumeRole"]
    sid                   = "AllowTelestreamCloudAssumeRole"
    effect                = "Allow"
    principal_type        = "AWS"
    principal_identifiers = ["078992246105"]
    conditions = [{
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["d6eeb23adcf5e42d64c07755d82b34da"]
    }]
  }]
  description = <<EOT
        description = "A list of assumne role statements, if using non blank sid must be unique or latest occurence of sid in list will overwirte prvious statement with same sid"
            assume_role_statements = {
                actions                 : "(Optional) List of actions that this statement either allows or denies. For example, ["ec2:RunInstances", "s3:*"]."
                sid                     : "(Optional) (statement ID) is an identifier for a policy statement."
                effect                  : "(Optional) Use Allow or Deny to indicate whether the policy allows or denies access."
                prinicple_type          : "(Required) Type of principal. Valid values include AWS, Service, Federated, CanonicalUser and *."
                principal_identifiers   : "(Required) List of identifiers for principals. When type is AWS, these are IAM principal ARNs, e.g., arn:aws:iam::12345678901:role/yak-role. When type is Service, these are AWS Service roles, e.g., lambda.amazonaws.com. When type is Federated, these are web identity users or SAML provider ARNs, e.g., accounts.google.com or arn:aws:iam::12345678901:saml-provider/yak-saml-provider. When type is CanonicalUser, these are canonical user IDs, e.g., 79a59df900b949e55d96a1e698fbacedfd6e09d98eacf8f8d5218e7cd47ef2be."
                principal               : "(Required in only some circumstances) – If you create a resource-based policy, you must indicate the account, user, role, or federated user to which you would like to allow or deny access. If you are creating an IAM permissions policy to attach to a user or role, you cannot include this element. The principal is implied as that user or role."          
                test                    : "(Required) Name of the IAM condition operator to evaluate."
                values                  : "(Required) Values to evaluate the condition against. If multiple values are provided, the condition matches if at least one of them applies. That is, AWS evaluates multiple values as though using an "OR" boolean operation."
                variable                : "(Required) Name of a Context Variable to apply the condition to. Context variables may either be standard AWS variables starting with aws: or service-specific variables prefixed with the service name."
            }
        EOT
  nullable    = false
}
//telestream access
variable "iam_access" {
  type = object({
    assume_role                    = optional(bool, true)
    create_iam                     = optional(bool, true)
    iam_role_name                  = optional(string)
    iam_role_name_prefix           = optional(string)
    iam_role_description           = optional(string, "Telestream Cloud Role used to access S3 Bucket, created by terraform")
    iam_role_tags                  = optional(map(string))
    iam_role_path                  = optional(string)
    iam_role_force_detach_policies = optional(bool)
    iam_role_max_session_duration  = optional(number)
    iam_role_permissions_boundary  = optional(string)
    iam_policy_name                = optional(string)
    iam_policy_name_prefix         = optional(string)
    iam_policy_description         = optional(string, "IAM Policy that grants Telestream Cloud permissions used to access S3 Bucket, created by terraform")
    iam_policy_path                = optional(string)
    iam_policy_policies            = optional(list(string), [])
    iam_policy_tags                = optional(map(string))
    iam_user_name                  = optional(string)
    iam_user_path                  = optional(string)
    iam_user_permissions_boundary  = optional(string)
    iam_user_force_destroy         = optional(bool)
    iam_user_tags                  = optional(map(string))
    iam_user_pgp_key               = optional(string)
    iam_user_key_status            = optional(string, "Active")
  })
  default = {
    assume_role = true
    create_iam  = true
  }
  description = <<EOT
        iam_access = {
            assume_role : "(Optional, Default true) How telestream cloud will access s3 bucket, by assuming a role or using access and secret keys. By default set to assume a role"
            create_iam  : "(Optional, Default true) If set to true will either create a iam role that telestream will assume, if assume_role is true. If assume_role is false telestream will use access keys and will create iam user with access and secret keys"
            iam_role_description             :"(Optional) Description of the role."
            iam_role_force_detach_policies   :"(Optional) Whether to force detaching any policies the role has before destroying it. Defaults to false."
            iam_role_max_session_duration    :"(Optional) Maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
            iam_role_name                    :"(Optional, Forces new resource) Friendly name of the role. If omitted, Terraform will assign a random, unique name. See IAM Identifiers for more information. for more infomation and naming convention rules https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html."
            iam_role_name_prefix             :"(Optional, Forces new resource) Creates a unique friendly name beginning with the specified prefix. Conflicts with name."
            iam_role_path                    :"(Optional) Path to the role. See IAM Identifiers for more information."
            iam_role_permissions_boundary    :"(Optional) ARN of the policy that is used to set the permissions boundary for the role."
            iam_role_tags                    :"(Optional) Key-value mapping of tags for the IAM role. If configured with a provider"
            iam_policy_description :"(Optional, Forces new resource) Description of the IAM policy."
            iam_policy_name        :"(Optional, Forces new resource) The name of the policy. If omitted, Terraform will assign a random, unique name, for more infomation and naming convention rules https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html."
            iam_policy_name_prefix :"(Optional, Forces new resource) Creates a unique name beginning with the specified prefix. Conflicts with name."
            iam_policy_path        :"(Optional, default '/') Path in which to create the policy. See IAM Identifiers for more information."
            iam_policy_policies    :"(Optional) The list of policy documents. This is a JSON formatted string file path. For more information about building AWS IAM policy documents with Terraform, see the AWS IAM Policy Document Guide"
            iam_policy_tags        :"(Optional) Map of resource tags for the IAM Policy. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
            iam_user_name                    :"(Required) The user's name. The name must consist of upper and lowercase alphanumeric characters with no spaces. You can also include any of the following characters: =,.@-_.. User names are not distinguished by case. For example, you cannot create users named both "TESTUSER" and "testuser". for more infomation and naming convention rules https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html."
            iam_user_path                    :"(Optional, default "/") Path in which to create the user."
            iam_user_permissions_boundary    :"(Optional) The ARN of the policy that is used to set the permissions boundary for the user."
            iam_user_force_destroy           :"(Optional, default false) When destroying this user, destroy even if it has non-Terraform-managed IAM access keys, login profile or MFA devices. Without force_destroy a user with non-Terraform-managed access keys and login profile will fail to be destroyed."
            iam_user_tags                    :"(Key-value map of tags for the IAM user. If configured with a provider default_tags configuration block present, tags with matching keys will overwrite those defined at the provider-level."
            iam_user_pgp_key                 :"(Requried) Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists, for use in the encrypted_secret output attribute. If providing a base-64 encoded PGP public key, make sure to provide the "raw" version and not the "armored" one (e.g. avoid passing the -a option to gpg --export)."
            iam_user_key_status                  :"(Optional) Access key status to apply. Defaults to Active. Valid values are Active and Inactive."
        }
    EOT
  nullable    = false
  validation {
    condition     = var.iam_access.create_iam && var.iam_access.assume_role ? var.iam_access.iam_role_name != null || var.iam_access.iam_role_name_prefix != null : true
    error_message = "iam_role name or iam_role Prefix must be set to a value, both can not be null."
  }
  validation {
    condition     = var.iam_access.create_iam && var.iam_access.assume_role ? var.iam_access.iam_role_name == null || var.iam_access.iam_role_name_prefix == null : true
    error_message = "iam_role name and iam_role Prefix conflict with each other one must have a value and one must be null."
  }
  validation {
    condition     = var.iam_access.create_iam ? var.iam_access.iam_policy_name != null || var.iam_access.iam_policy_name_prefix != null : true
    error_message = "iam_policy name or iam_policy Prefix must be set to a value, both can not be null."
  }
  validation {
    condition     = var.iam_access.create_iam ? var.iam_access.iam_policy_name == null || var.iam_access.iam_policy_name_prefix == null : true
    error_message = "iam_policy name and iam_policy Prefix conflict with each other one must have a value and one must be null."
  }
  validation {
    condition     = var.iam_access.create_iam && !var.iam_access.assume_role ? var.iam_access.iam_user_name != null : true
    error_message = "iam_user name is required and cannot be left null, for more infomation and naming convention for iam user names rules https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html"
  }
  validation {
    condition     = var.iam_access.create_iam && !var.iam_access.assume_role ? contains(["Active", "Inactive"], var.iam_access.iam_user_key_status) : true
    error_message = "status only valid values are Active and Inactive"
  }
}

