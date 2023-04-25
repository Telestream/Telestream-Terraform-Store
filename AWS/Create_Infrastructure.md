
# How to Deploy Infrastructure AWS
Terraform Build Infrastructure Documentation can be found [here](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build)

# Table of Contents
1. [Requirements](README.md)
2. [Select Example module](#select-example-module)
3. [Copy a module](#copy-a-module)
4. [Creating a Terraform Environment Deployment Folder](#creating-a-terraform-environment-deployment-folder)
5. [Replace values in example module](#replace-values-in-example-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

# Select Example module

Pick an [Example](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples) module that best fits your requirements, the examples bellow will be using Create_S3_Bucket_And_IAM_Role.

# Copy a module

Copy the main.tf in the[Examples](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples) that you want to use in a safe and secure place since terraform will generate a [state](https://developer.hashicorp.com/terraform/language/state)file. The Terraform state file is a JSON file that contains the current state of the infrastructure resources managed by Terraform. It keeps track of the resources that Terraform created, updated, or destroyed during the last run. The Terraform state file is crucial because it enables Terraform to perform operations like update, destroy, or create resources based on the current state. Without the state file, Terraform would not know which resources to update, destroy or create, making infrastructure management difficult.

<br />

In addition, the Terraform state file allows for collaborative infrastructure management. When multiple team members work on the same infrastructure, the state file serves as a shared record of the current infrastructure state. This allows team members to collaborate effectively and avoid conflicts.

# Creating a Terraform Environment Deployment Folder

To create a new Terraform environment deployment, follow the steps below:

1. Create a new folder and name it `terraform`
2. Inside the `terraform` folder, create another folder named after the environment you want to deploy to (e.g., sandbox, dev, staging, or prod).
3. Inside the environment folder, create a new folder to store the Terraform main. The folder name should be descriptive of what the Terraform code does. For example, if you are creating S3 buckets in the cloud, the folder name could be `tcloud-s3-buckets`.
4. Best practices name the terraform file as main.tf\`. 

By following the above steps, you can create a new Terraform environment deployment folder and organize your Terraform code effectively. Keeping Terraform separate for different environments is a good practice that helps prevent any conflicts and simplifies the deployment process.

<br />

# Replace values in example module

Below is the example `main.tf` for creating a list of AWS S3 buckets and AWS IAM Role that has access to buckets created. Any line 

Original:

```json
provider "aws" {
    region  = "<replace_with_region_to_deploy_into>"
    profile = "<replace_with_profile_name>"
}

module "bucket" {
    source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
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



## Use AWS CLI Profile in Modules

Deploying infrastructure using Terraform requires the provider with credentials, documentation can be found [here](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

<br />

The Top of the module has a provider field that determines the region and credentials for AWS, that needs to be updated with correct values.

```json
provider "aws" {
    region  = "<replace_with_region_to_deploy_into>"
    profile = "<replace_with_profile_name>"
}
```



<br />

Example:

```json
provider "aws" {
    region  = "us-east-1"
    profile = "tcloud-store-prod"
}
```



- region: value is the the region you will build S3 buckets in, so if you enter us-east-1 then the S3 bucket will be in the us-east-1 region. This value is required
- profile: use the AWS CLI profile name created in previous [page](https://dash.readme.com/project/telestream/v1.2/docs/how-to-configure-aws-cli-profile) terraform will use the profile to interact with AWS

## Replace terraform module inputs:

Example:

```json
provider "aws" {
    region  = "us-east-1"
    profile = "tcloud-store-prod"
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



<br />

- bucket_names: Please provide a comma-separated list of names for the AWS S3 buckets you wish to create. Ensure that the names follow the AWS S3 bucket naming convention outlined in the following link: <https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html>
- iam_policy_name: The name of the IAM policy. Ensure that the names follow the AWS IAM naming convention outlined in the following link: link: <https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html>
- iam_role_name: The name of the IAM role. Ensure that the names follow the AWS IAM naming convention outlined in the following link: <https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_iam-quotas.html>

## Initialize the Directory

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the AWS provider. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/init)

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