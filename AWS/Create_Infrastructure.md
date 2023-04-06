# How to Deploy Infrastructure AWS
Terraform Build Infrastructure Documentation can be found [here][terraform-build-infrastructure]

# Table of Contents
1. [Requirements](README.md)
2. [Copy Module](#copy-a-module)
3. [Replace values in module](#replace-values-in-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build
[terraform-init]:https://developer.hashicorp.com/terraform/cli/commands/init
[terraform-plan]:https://developer.hashicorp.com/terraform/cli/commands/plan
[terraform-apply]:https://developer.hashicorp.com/terraform/cli/commands/apply
[aws-examples]:https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples
[aws-example]:https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples/iam_role_access
# Copy a module
Copy the module in [Examples][aws-examples] directory that fits your requirements. Example module in examples will be the [iam_role_access][aws-example] module
# Replace values in module
Original:
```json
provider "aws" {
    region  = "<replace_with_region_to_deploy_into>"
    profile = "<replace_with_profile_name>"
}

module "bucket" {
    source       = "../../Bucket"
    bucket_names = ["<replace_with_unique_name_of_bucket>"]
    iam_access = {
        iam_policy_name  = "<replace_with_unique_name_for_policy>"
        iam_role_name    = "<replace_with_unique_name_for_role>"
    }
}

output "bucket_names" {
  value       = module.bucket.id
  description = "list of the of names of the buckets created by terraform"
}
output "bucket_arns" {
  value       = module.bucket.arn
  description = "list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]."
}
output "iam_policy_arn" {
  value       = module.bucket.iam_policy_arn
  description = "The ARN assigned by AWS to this policy."
}
output "iam_role_arn" {
  value       = module.bucket.iam_role_arn
  description = "Amazon Resource Name (ARN) specifying the role."
}
```
Example:
```json
provider "aws" {
    region  = "us-east-1"
    profile = "telestream-dev"
}

module "bucket" {
    source       = "../../Bucket"
    bucket_names = ["fake-bucket-name"]
    iam_access = {
        iam_policy_name  = "tcloud_store_access_policy"
        iam_role_name    = "tcloud_store_access_role"
    }
}

output "bucket_names" {
  value       = module.bucket.id
  description = "list of the of names of the buckets created by terraform"
}
output "bucket_arns" {
  value       = module.bucket.arn
  description = "list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]."
}
output "iam_policy_arn" {
  value       = module.bucket.iam_policy_arn
  description = "The ARN assigned by AWS to this policy."
}
output "iam_role_arn" {
  value       = module.bucket.iam_role_arn
  description = "Amazon Resource Name (ARN) specifying the role."
}
```
# Initialize the Directory
When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the aws provider. Terraform documentation can be found [here][terraform-init]
```sh
terraform init
```
Example:
```sh
$ terraform init
Initializing modules...
- bucket in ../../Bucket

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/aws versions matching "4.59.0"...
- Installing hashicorp/aws v4.59.0...
- Installed hashicorp/aws v4.59.0 (signed by HashiCorp)

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
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2847671425]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.bucket.aws_iam_policy.policy[0] will be created
  + resource "aws_iam_policy" "policy" {
      + arn         = (known after apply)
      + description = "IAM Policy that grants Telestream Cloud permissions used to access S3 Bucket, created by terraform"
      + id          = (known after apply)
      + name        = "tcloud_store_access_policy"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Id        = "PandaStreamBucketPolicy"
              + Statement = [
                  + {
                      + Action   = [
                          + "s3:AbortMultipartUpload",
                          + "s3:GetObjectAcl",
                          + "s3:DeleteObject",
                          + "s3:GetObject",
                          + "s3:PutObjectAcl",
                          + "s3:ListMultipartUploadParts",
                          + "s3:PutObject",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::fake-bucket-name/*"
                      + Sid      = "AllowBucketObjectsAccess0"
                    },
                  + {
                      + Action   = [
                          + "s3:GetBucketAcl",
                          + "s3:ListBucket",
                          + "s3:ListBucketMultipartUploads",
                          + "s3:GetBucketLocation",
                          + "s3:PutBucketAcl",
                          + "s3:GetBucketNotification",
                          + "s3:PutBucketNotification",
                          + "s3:GetBucketPolicy",
                          + "s3:PutBucketPolicy",
                          + "s3:DeleteBucketPolicy",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::fake-bucket-name"
                      + Sid      = "AllowBucketAccess0"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = (known after apply)
    }

  # module.bucket.aws_iam_role.role[0] will be created
  + resource "aws_iam_role" "role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Condition = {
                          + StringEquals = {
                              + "sts:ExternalId" = [
                                  + "d6eeb23adcf5e42d64c07755d82b34da",
                                ]
                            }
                        }
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = "078992246105"
                        }
                      + Sid       = "AllowTelestreamCloudAssumeRole"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Telestream Cloud Role used to access S3 Bucket, created by terraform"
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "tcloud_store_access_role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0] will be created
  + resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "tcloud_store_access_role"
    }

  # module.bucket.aws_s3_bucket.bucket[0] will be created
  + resource "aws_s3_bucket" "bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "fake-bucket-name"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule {
          + allowed_headers = (known after apply)
          + allowed_methods = (known after apply)
          + allowed_origins = (known after apply)
          + expose_headers  = (known after apply)
          + max_age_seconds = (known after apply)
        }

      + grant {
          + id          = (known after apply)
          + permissions = (known after apply)
          + type        = (known after apply)
          + uri         = (known after apply)
        }

      + lifecycle_rule {
          + abort_incomplete_multipart_upload_days = (known after apply)
          + enabled                                = (known after apply)
          + id                                     = (known after apply)
          + prefix                                 = (known after apply)
          + tags                                   = (known after apply)

          + expiration {
              + date                         = (known after apply)
              + days                         = (known after apply)
              + expired_object_delete_marker = (known after apply)
            }

          + noncurrent_version_expiration {
              + days = (known after apply)
            }

          + noncurrent_version_transition {
              + days          = (known after apply)
              + storage_class = (known after apply)
            }

          + transition {
              + date          = (known after apply)
              + days          = (known after apply)
              + storage_class = (known after apply)
            }
        }

      + logging {
          + target_bucket = (known after apply)
          + target_prefix = (known after apply)
        }

      + object_lock_configuration {
          + object_lock_enabled = (known after apply)

          + rule {
              + default_retention {
                  + days  = (known after apply)
                  + mode  = (known after apply)
                  + years = (known after apply)
                }
            }
        }

      + replication_configuration {
          + role = (known after apply)

          + rules {
              + delete_marker_replication_status = (known after apply)
              + id                               = (known after apply)
              + prefix                           = (known after apply)
              + priority                         = (known after apply)
              + status                           = (known after apply)

              + destination {
                  + account_id         = (known after apply)
                  + bucket             = (known after apply)
                  + replica_kms_key_id = (known after apply)
                  + storage_class      = (known after apply)

                  + access_control_translation {
                      + owner = (known after apply)
                    }

                  + metrics {
                      + minutes = (known after apply)
                      + status  = (known after apply)
                    }

                  + replication_time {
                      + minutes = (known after apply)
                      + status  = (known after apply)
                    }
                }

              + filter {
                  + prefix = (known after apply)
                  + tags   = (known after apply)
                }

              + source_selection_criteria {
                  + sse_kms_encrypted_objects {
                      + enabled = (known after apply)
                    }
                }
            }
        }

      + server_side_encryption_configuration {
          + rule {
              + bucket_key_enabled = (known after apply)

              + apply_server_side_encryption_by_default {
                  + kms_master_key_id = (known after apply)
                  + sse_algorithm     = (known after apply)
                }
            }
        }

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }

      + website {
          + error_document           = (known after apply)
          + index_document           = (known after apply)
          + redirect_all_requests_to = (known after apply)
          + routing_rules            = (known after apply)
        }
    }

  # module.bucket.aws_s3_bucket_ownership_controls.ownership[0] will be created
  + resource "aws_s3_bucket_ownership_controls" "ownership" {
      + bucket = (known after apply)
      + id     = (known after apply)

      + rule {
          + object_ownership = "BucketOwnerEnforced"
        }
    }

  # module.bucket.aws_s3_bucket_public_access_block.block_access[0] will be created
  + resource "aws_s3_bucket_public_access_block" "block_access" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + restrict_public_buckets = true
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_arns    = (known after apply)
  + bucket_names   = (known after apply)
  + iam_policy_arn = (known after apply)
  + iam_role_arn   = (known after apply)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
now.
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
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2847671425]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.bucket.aws_iam_policy.policy[0] will be created
  + resource "aws_iam_policy" "policy" {
      + arn         = (known after apply)
      + description = "IAM Policy that grants Telestream Cloud permissions used to access S3 Bucket, created by terraform"
      + id          = (known after apply)
      + name        = "tcloud_store_access_policy"
      + path        = "/"
      + policy      = jsonencode(
            {
              + Id        = "PandaStreamBucketPolicy"
              + Statement = [
                  + {
                      + Action   = [
                          + "s3:AbortMultipartUpload",
                          + "s3:GetObjectAcl",
                          + "s3:DeleteObject",
                          + "s3:GetObject",
                          + "s3:PutObjectAcl",
                          + "s3:ListMultipartUploadParts",
                          + "s3:PutObject",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::fake-bucket-name/*"
                      + Sid      = "AllowBucketObjectsAccess0"
                    },
                  + {
                      + Action   = [
                          + "s3:GetBucketAcl",
                          + "s3:ListBucket",
                          + "s3:ListBucketMultipartUploads",
                          + "s3:GetBucketLocation",
                          + "s3:PutBucketAcl",
                          + "s3:GetBucketNotification",
                          + "s3:PutBucketNotification",
                          + "s3:GetBucketPolicy",
                          + "s3:PutBucketPolicy",
                          + "s3:DeleteBucketPolicy",
                        ]
                      + Effect   = "Allow"
                      + Resource = "arn:aws:s3:::fake-bucket-name"
                      + Sid      = "AllowBucketAccess0"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + policy_id   = (known after apply)
      + tags_all    = (known after apply)
    }

  # module.bucket.aws_iam_role.role[0] will be created
  + resource "aws_iam_role" "role" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Condition = {
                          + StringEquals = {
                              + "sts:ExternalId" = [
                                  + "d6eeb23adcf5e42d64c07755d82b34da",
                                ]
                            }
                        }
                      + Effect    = "Allow"
                      + Principal = {
                          + AWS = "078992246105"
                        }
                      + Sid       = "AllowTelestreamCloudAssumeRole"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + description           = "Telestream Cloud Role used to access S3 Bucket, created by terraform"
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "tcloud_store_access_role"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0] will be created
  + resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
      + id         = (known after apply)
      + policy_arn = (known after apply)
      + role       = "tcloud_store_access_role"
    }

  # module.bucket.aws_s3_bucket.bucket[0] will be created
  + resource "aws_s3_bucket" "bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      + arn                         = (known after apply)
      + bucket                      = "fake-bucket-name"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + object_lock_enabled         = (known after apply)
      + policy                      = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + tags_all                    = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + cors_rule {
          + allowed_headers = (known after apply)
          + allowed_methods = (known after apply)
          + allowed_origins = (known after apply)
          + expose_headers  = (known after apply)
          + max_age_seconds = (known after apply)
        }

      + grant {
          + id          = (known after apply)
          + permissions = (known after apply)
          + type        = (known after apply)
          + uri         = (known after apply)
        }

      + lifecycle_rule {
          + abort_incomplete_multipart_upload_days = (known after apply)
          + enabled                                = (known after apply)
          + id                                     = (known after apply)
          + prefix                                 = (known after apply)
          + tags                                   = (known after apply)

          + expiration {
              + date                         = (known after apply)
              + days                         = (known after apply)
              + expired_object_delete_marker = (known after apply)
            }

          + noncurrent_version_expiration {
              + days = (known after apply)
            }

          + noncurrent_version_transition {
              + days          = (known after apply)
              + storage_class = (known after apply)
            }

          + transition {
              + date          = (known after apply)
              + days          = (known after apply)
              + storage_class = (known after apply)
            }
        }

      + logging {
          + target_bucket = (known after apply)
          + target_prefix = (known after apply)
        }

      + object_lock_configuration {
          + object_lock_enabled = (known after apply)

          + rule {
              + default_retention {
                  + days  = (known after apply)
                  + mode  = (known after apply)
                  + years = (known after apply)
                }
            }
        }

      + replication_configuration {
          + role = (known after apply)

          + rules {
              + delete_marker_replication_status = (known after apply)
              + id                               = (known after apply)
              + prefix                           = (known after apply)
              + priority                         = (known after apply)
              + status                           = (known after apply)

              + destination {
                  + account_id         = (known after apply)
                  + bucket             = (known after apply)
                  + replica_kms_key_id = (known after apply)
                  + storage_class      = (known after apply)

                  + access_control_translation {
                      + owner = (known after apply)
                    }

                  + metrics {
                      + minutes = (known after apply)
                      + status  = (known after apply)
                    }

                  + replication_time {
                      + minutes = (known after apply)
                      + status  = (known after apply)
                    }
                }

              + filter {
                  + prefix = (known after apply)
                  + tags   = (known after apply)
                }

              + source_selection_criteria {
                  + sse_kms_encrypted_objects {
                      + enabled = (known after apply)
                    }
                }
            }
        }

      + server_side_encryption_configuration {
          + rule {
              + bucket_key_enabled = (known after apply)

              + apply_server_side_encryption_by_default {
                  + kms_master_key_id = (known after apply)
                  + sse_algorithm     = (known after apply)
                }
            }
        }

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }

      + website {
          + error_document           = (known after apply)
          + index_document           = (known after apply)
          + redirect_all_requests_to = (known after apply)
          + routing_rules            = (known after apply)
        }
    }

  # module.bucket.aws_s3_bucket_ownership_controls.ownership[0] will be created
  + resource "aws_s3_bucket_ownership_controls" "ownership" {
      + bucket = (known after apply)
      + id     = (known after apply)

      + rule {
          + object_ownership = "BucketOwnerEnforced"
        }
    }

  # module.bucket.aws_s3_bucket_public_access_block.block_access[0] will be created
  + resource "aws_s3_bucket_public_access_block" "block_access" {
      + block_public_acls       = true
      + block_public_policy     = true
      + bucket                  = (known after apply)
      + id                      = (known after apply)
      + ignore_public_acls      = true
      + restrict_public_buckets = true
    }

Plan: 6 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + bucket_arns    = (known after apply)
  + bucket_names   = (known after apply)
  + iam_policy_arn = (known after apply)
  + iam_role_arn   = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.bucket.aws_iam_policy.policy[0]: Creating...
module.bucket.aws_iam_role.role[0]: Creating...
module.bucket.aws_s3_bucket.bucket[0]: Creating...
module.bucket.aws_iam_policy.policy[0]: Creation complete after 1s [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.aws_iam_role.role[0]: Creation complete after 1s [id=tcloud_store_access_role]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Creating...
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Creation complete after 0s [id=tcloud_store_access_role-20230325173854024100000001]
module.bucket.aws_s3_bucket.bucket[0]: Creation complete after 2s [id=fake-bucket-name]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Creating...
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Creating...
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Creation complete after 0s [id=fake-bucket-name]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Creation complete after 0s [id=fake-bucket-name]

Apply complete! Resources: 6 added, 0 changed, 0 destroyed.

Outputs:

bucket_arns = "arn:aws:s3:::fake-bucket-name"
bucket_names = "fake-bucket-name"
iam_policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy"
iam_role_arn = "arn:aws:iam::012345678901:role/tcloud_store_access_role"
$ 
```