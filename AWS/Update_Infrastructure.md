# How to Update Infrastructure AWS
# NOTE if changing the bucket names, terraform will attempt to delete the existing buckets and all objects inside, so be careful and read terraform output on what will be destroyed

Terraform Build Infrastructure Documentation can be found [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)
<br />

Go into the directory with the `main.tf` and `terraform.tfstate` to run the terraform destroy command.
# Table of Contents
1. [Requirements](README.md)
3. [Update values in module](#update-values-in-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

## Update values in module

To update values after deployed, just change values in main.tf to new values you want. Example changing the policy, role name, or bucket names. Changing bucket name will have terraform destroy old buckets and everything in it and create a new bucket, this will result of losing all objects in the s3 bucket. 

<br /> 
Example bellow will update iam_policy and iam_role name as well as the bucket names.

Original:

```json
provider "aws" {
    region  = "us-east-1"
    profile = "telestream-dev"
}

module "bucket" {
    source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
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



Update:

```json
provider "aws" {
    region  = "us-east-1"
    profile = "telestream-dev"
}

module "bucket" {
    source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
    bucket_names = ["fake-bucket-name-new"]
    iam_access = {
        iam_policy_name  = "tcloud_store_access_policy_new"
        iam_role_name    = "tcloud_store_access_role_new"
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



<br />

## Initialize the Directory

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the aws provider. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/init)

```sh
terraform init
```



Example:

```sh
$ terraform init
Initializing modules...
- bucket in github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket

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



<br />

## Terraform Plan

The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. The plan command alone does not actually carry out the proposed changes. You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/plan)

```sh
terraform plan
```



In the output plan it shows that it will create new infrastructure and destroy old infrastructure by saying `Plan: 6 to add, 0 to change, 6 to destroy.` So use plan to verify expected changes, if you do not mean to destroy anything this is giving you a warning that your action will destroy infrastructure.

Example:

```sh
$ terraform plan
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=4088149558]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.aws_iam_policy.policy[0]: Refreshing state... [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.aws_s3_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]
module.bucket.aws_iam_role.role[0]: Refreshing state... [id=tcloud_store_access_role]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Refreshing state... [id=tcloud_store_access_role-20230325173854024100000001]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Refreshing state... [id=fake-bucket-name]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.bucket.aws_iam_policy.policy[0] has changed
  ~ resource "aws_iam_policy" "policy" {
        id          = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy"
        name        = "tcloud_store_access_policy"
      + tags        = {}
        # (6 unchanged attributes hidden)
    }

  # module.bucket.aws_iam_role.role[0] has changed
  ~ resource "aws_iam_role" "role" {
        id                    = "tcloud_store_access_role"
      ~ managed_policy_arns   = [
          + "arn:aws:iam::012345678901:policy/tcloud_store_access_policy",
        ]
        name                  = "tcloud_store_access_role"
      + tags                  = {}
        # (9 unchanged attributes hidden)
    }

  # module.bucket.aws_s3_bucket.bucket[0] has changed
  ~ resource "aws_s3_bucket" "bucket" {
        id                          = "fake-bucket-name"
      + tags                        = {}
        # (10 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may
include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.bucket.aws_iam_policy.policy[0] must be replaced
-/+ resource "aws_iam_policy" "policy" {
      ~ arn         = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply)
      ~ id          = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply)
      ~ name        = "tcloud_store_access_policy" -> "tcloud_store_access_policy_new" # forces replacement
      ~ policy      = jsonencode(
          ~ {
              ~ Statement = [
                  ~ {
                      ~ Resource = "arn:aws:s3:::fake-bucket-name/*" -> "arn:aws:s3:::fake-bucket-name-new/*"
                        # (3 unchanged elements hidden)
                    },
                  ~ {
                      ~ Resource = "arn:aws:s3:::fake-bucket-name" -> "arn:aws:s3:::fake-bucket-name-new"
                        # (3 unchanged elements hidden)
                    },
                ]
                # (2 unchanged elements hidden)
            }
        )
      ~ policy_id   = "ANPA5TRHZWO35GEPAZLFP" -> (known after apply)
      - tags        = {} -> null
      ~ tags_all    = {} -> (known after apply)
        # (2 unchanged attributes hidden)
    }

  # module.bucket.aws_iam_role.role[0] must be replaced
-/+ resource "aws_iam_role" "role" {
      ~ arn                   = "arn:aws:iam::012345678901:role/tcloud_store_access_role" -> (known after apply)
      ~ create_date           = "2023-03-25T17:38:53Z" -> (known after apply)
      ~ id                    = "tcloud_store_access_role" -> (known after apply)
      ~ managed_policy_arns   = [
          - "arn:aws:iam::012345678901:policy/tcloud_store_access_policy",
        ] -> (known after apply)
      ~ name                  = "tcloud_store_access_role" -> "tcloud_store_access_role_new" # forces replacement
      + name_prefix           = (known after apply)
      - tags                  = {} -> null
      ~ tags_all              = {} -> (known after apply)
      ~ unique_id             = "AROA5TRHZWO3VSPSGKQBK" -> (known after apply)
        # (5 unchanged attributes hidden)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0] must be replaced
-/+ resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
      ~ id         = "tcloud_store_access_role-20230325173854024100000001" -> (known after apply)
      ~ policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply) # forces replacement
      ~ role       = "tcloud_store_access_role" -> "tcloud_store_access_role_new" # forces replacement
    }

  # module.bucket.aws_s3_bucket.bucket[0] must be replaced
-/+ resource "aws_s3_bucket" "bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      ~ arn                         = "arn:aws:s3:::fake-bucket-name" -> (known after apply)
      ~ bucket                      = "fake-bucket-name" -> "fake-bucket-name-new" # forces replacement
      ~ bucket_domain_name          = "fake-bucket-name.s3.amazonaws.com" -> (known after apply)
      ~ bucket_regional_domain_name = "fake-bucket-name.s3.amazonaws.com" -> (known after apply)
      ~ hosted_zone_id              = "Z3AQBSTGFYJSTF" -> (known after apply)
      ~ id                          = "fake-bucket-name" -> (known after apply)
      ~ object_lock_enabled         = false -> (known after apply)
      + policy                      = (known after apply)
      ~ region                      = "us-east-1" -> (known after apply)
      ~ request_payer               = "BucketOwner" -> (known after apply)
      - tags                        = {} -> null
      ~ tags_all                    = {} -> (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
        # (1 unchanged attribute hidden)

      + cors_rule {
          + allowed_headers = (known after apply)
          + allowed_methods = (known after apply)
          + allowed_origins = (known after apply)
          + expose_headers  = (known after apply)
          + max_age_seconds = (known after apply)
        }

      - grant {
          - id          = "31bf468d4036a82729c4a81a3322c4c7c236dcbd5e4b185639d3ba13825cbde8" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
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

      ~ server_side_encryption_configuration {
          ~ rule {
              ~ bucket_key_enabled = false -> (known after apply)

              ~ apply_server_side_encryption_by_default {
                  + kms_master_key_id = (known after apply)
                  ~ sse_algorithm     = "AES256" -> (known after apply)
                }
            }
        }

      ~ versioning {
          ~ enabled    = false -> (known after apply)
          ~ mfa_delete = false -> (known after apply)
        }

      + website {
          + error_document           = (known after apply)
          + index_document           = (known after apply)
          + redirect_all_requests_to = (known after apply)
          + routing_rules            = (known after apply)
        }
    }

  # module.bucket.aws_s3_bucket_ownership_controls.ownership[0] must be replaced
-/+ resource "aws_s3_bucket_ownership_controls" "ownership" {
      ~ bucket = "fake-bucket-name" -> (known after apply) # forces replacement
      ~ id     = "fake-bucket-name" -> (known after apply)

        # (1 unchanged block hidden)
    }

  # module.bucket.aws_s3_bucket_public_access_block.block_access[0] must be replaced
-/+ resource "aws_s3_bucket_public_access_block" "block_access" {
      ~ bucket                  = "fake-bucket-name" -> (known after apply) # forces replacement
      ~ id                      = "fake-bucket-name" -> (known after apply)
        # (4 unchanged attributes hidden)
    }

Plan: 6 to add, 0 to change, 6 to destroy.

Changes to Outputs:
  ~ bucket_arns    = "arn:aws:s3:::fake-bucket-name" -> (known after apply)
  ~ bucket_names   = "fake-bucket-name" -> (known after apply)
  ~ iam_policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply)
  ~ iam_role_arn   = "arn:aws:iam::012345678901:role/tcloud_store_access_role" -> (known after apply)

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply"
now.
$ 
```



<br />

## Create Infrastructure

The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, enter yes to approve. After approval it will create infrastructure. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/apply)

```sh
terraform apply
```



Example:

```sh
$ terraform apply
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.aws_s3_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=4088149558]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.aws_iam_policy.policy[0]: Refreshing state... [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]
module.bucket.aws_iam_role.role[0]: Refreshing state... [id=tcloud_store_access_role]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Refreshing state... [id=tcloud_store_access_role-20230325173854024100000001]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Refreshing state... [id=fake-bucket-name]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.bucket.aws_iam_policy.policy[0] has changed
  ~ resource "aws_iam_policy" "policy" {
        id          = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy"
        name        = "tcloud_store_access_policy"
      + tags        = {}
        # (6 unchanged attributes hidden)
    }

  # module.bucket.aws_iam_role.role[0] has changed
  ~ resource "aws_iam_role" "role" {
        id                    = "tcloud_store_access_role"
      ~ managed_policy_arns   = [
          + "arn:aws:iam::012345678901:policy/tcloud_store_access_policy",
        ]
        name                  = "tcloud_store_access_role"
      + tags                  = {}
        # (9 unchanged attributes hidden)
    }

  # module.bucket.aws_s3_bucket.bucket[0] has changed
  ~ resource "aws_s3_bucket" "bucket" {
        id                          = "fake-bucket-name"
      + tags                        = {}
        # (10 unchanged attributes hidden)

        # (3 unchanged blocks hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may
include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.bucket.aws_iam_policy.policy[0] must be replaced
-/+ resource "aws_iam_policy" "policy" {
      ~ arn         = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply)
      ~ id          = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply)
      ~ name        = "tcloud_store_access_policy" -> "tcloud_store_access_policy_new" # forces replacement
      ~ policy      = jsonencode(
          ~ {
              ~ Statement = [
                  ~ {
                      ~ Resource = "arn:aws:s3:::fake-bucket-name/*" -> "arn:aws:s3:::fake-bucket-name-new/*"
                        # (3 unchanged elements hidden)
                    },
                  ~ {
                      ~ Resource = "arn:aws:s3:::fake-bucket-name" -> "arn:aws:s3:::fake-bucket-name-new"
                        # (3 unchanged elements hidden)
                    },
                ]
                # (2 unchanged elements hidden)
            }
        )
      ~ policy_id   = "ANPA5TRHZWO35GEPAZLFP" -> (known after apply)
      - tags        = {} -> null
      ~ tags_all    = {} -> (known after apply)
        # (2 unchanged attributes hidden)
    }

  # module.bucket.aws_iam_role.role[0] must be replaced
-/+ resource "aws_iam_role" "role" {
      ~ arn                   = "arn:aws:iam::012345678901:role/tcloud_store_access_role" -> (known after apply)
      ~ create_date           = "2023-03-25T17:38:53Z" -> (known after apply)
      ~ id                    = "tcloud_store_access_role" -> (known after apply)
      ~ managed_policy_arns   = [
          - "arn:aws:iam::012345678901:policy/tcloud_store_access_policy",
        ] -> (known after apply)
      ~ name                  = "tcloud_store_access_role" -> "tcloud_store_access_role_new" # forces replacement
      + name_prefix           = (known after apply)
      - tags                  = {} -> null
      ~ tags_all              = {} -> (known after apply)
      ~ unique_id             = "AROA5TRHZWO3VSPSGKQBK" -> (known after apply)
        # (5 unchanged attributes hidden)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0] must be replaced
-/+ resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
      ~ id         = "tcloud_store_access_role-20230325173854024100000001" -> (known after apply)
      ~ policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply) # forces replacement
      ~ role       = "tcloud_store_access_role" -> "tcloud_store_access_role_new" # forces replacement
    }

  # module.bucket.aws_s3_bucket.bucket[0] must be replaced
-/+ resource "aws_s3_bucket" "bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = (known after apply)
      ~ arn                         = "arn:aws:s3:::fake-bucket-name" -> (known after apply)
      ~ bucket                      = "fake-bucket-name" -> "fake-bucket-name-new" # forces replacement
      ~ bucket_domain_name          = "fake-bucket-name.s3.amazonaws.com" -> (known after apply)
      ~ bucket_regional_domain_name = "fake-bucket-name.s3.amazonaws.com" -> (known after apply)
      ~ hosted_zone_id              = "Z3AQBSTGFYJSTF" -> (known after apply)
      ~ id                          = "fake-bucket-name" -> (known after apply)
      ~ object_lock_enabled         = false -> (known after apply)
      + policy                      = (known after apply)
      ~ region                      = "us-east-1" -> (known after apply)
      ~ request_payer               = "BucketOwner" -> (known after apply)
      - tags                        = {} -> null
      ~ tags_all                    = {} -> (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)
        # (1 unchanged attribute hidden)

      + cors_rule {
          + allowed_headers = (known after apply)
          + allowed_methods = (known after apply)
          + allowed_origins = (known after apply)
          + expose_headers  = (known after apply)
          + max_age_seconds = (known after apply)
        }

      - grant {
          - id          = "31bf468d4036a82729c4a81a3322c4c7c236dcbd5e4b185639d3ba13825cbde8" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
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

      ~ server_side_encryption_configuration {
          ~ rule {
              ~ bucket_key_enabled = false -> (known after apply)

              ~ apply_server_side_encryption_by_default {
                  + kms_master_key_id = (known after apply)
                  ~ sse_algorithm     = "AES256" -> (known after apply)
                }
            }
        }

      ~ versioning {
          ~ enabled    = false -> (known after apply)
          ~ mfa_delete = false -> (known after apply)
        }

      + website {
          + error_document           = (known after apply)
          + index_document           = (known after apply)
          + redirect_all_requests_to = (known after apply)
          + routing_rules            = (known after apply)
        }
    }

  # module.bucket.aws_s3_bucket_ownership_controls.ownership[0] must be replaced
-/+ resource "aws_s3_bucket_ownership_controls" "ownership" {
      ~ bucket = "fake-bucket-name" -> (known after apply) # forces replacement
      ~ id     = "fake-bucket-name" -> (known after apply)

        # (1 unchanged block hidden)
    }

  # module.bucket.aws_s3_bucket_public_access_block.block_access[0] must be replaced
-/+ resource "aws_s3_bucket_public_access_block" "block_access" {
      ~ bucket                  = "fake-bucket-name" -> (known after apply) # forces replacement
      ~ id                      = "fake-bucket-name" -> (known after apply)
        # (4 unchanged attributes hidden)
    }

Plan: 6 to add, 0 to change, 6 to destroy.

Changes to Outputs:
  ~ bucket_arns    = "arn:aws:s3:::fake-bucket-name" -> (known after apply)
  ~ bucket_names   = "fake-bucket-name" -> (known after apply)
  ~ iam_policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> (known after apply)
  ~ iam_role_arn   = "arn:aws:iam::012345678901:role/tcloud_store_access_role" -> (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Destroying... [id=tcloud_store_access_role-20230325173854024100000001]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Destroying... [id=fake-bucket-name]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Destroying... [id=fake-bucket-name]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Destruction complete after 0s
module.bucket.aws_iam_policy.policy[0]: Destroying... [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.aws_iam_role.role[0]: Destroying... [id=tcloud_store_access_role]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Destruction complete after 0s
module.bucket.aws_iam_policy.policy[0]: Destruction complete after 0s
module.bucket.aws_iam_policy.policy[0]: Creating...
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Destruction complete after 0s
module.bucket.aws_s3_bucket.bucket[0]: Destroying... [id=fake-bucket-name]
module.bucket.aws_iam_role.role[0]: Destruction complete after 0s
module.bucket.aws_iam_role.role[0]: Creating...
module.bucket.aws_s3_bucket.bucket[0]: Destruction complete after 0s
module.bucket.aws_s3_bucket.bucket[0]: Creating...
module.bucket.aws_iam_policy.policy[0]: Creation complete after 0s [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy_new]
module.bucket.aws_iam_role.role[0]: Creation complete after 1s [id=tcloud_store_access_role_new]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Creating...
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Creation complete after 0s [id=tcloud_store_access_role_new-20230325175057670700000001]
module.bucket.aws_s3_bucket.bucket[0]: Creation complete after 2s [id=fake-bucket-name-new]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Creating...
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Creating...
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Creation complete after 0s [id=fake-bucket-name-new]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Creation complete after 0s [id=fake-bucket-name-new]

Apply complete! Resources: 6 added, 0 changed, 6 destroyed.

Outputs:

bucket_arns = "arn:aws:s3:::fake-bucket-name-new"
bucket_names = "fake-bucket-name-new"
iam_policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy_new"
iam_role_arn = "arn:aws:iam::012345678901:role/tcloud_store_access_role_new"
$ 
```