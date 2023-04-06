
# How to Destroy Infrastructure
Terraform Build Infrastructure Documentation can be found [here][terraform-build-infrastructure]

# Table of Contents
1. [Requirements](README.md)
2. [Initialize the Directory](#initialize-the-directory)
3. [Destroy Infrastructure](#destroy-infrastructure)

[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build
[terraform-init]:https://developer.hashicorp.com/terraform/cli/commands/init
[terraform-destroy]:https://developer.hashicorp.com/terraform/cli/commands/destroy

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
# Destroy Infrastructure
The terraform destroy command destroys all of the resources being managed by the current working directory and workspace, using state data to determine which real world objects correspond to managed resources. Like terraform apply, it asks for confirmation before proceeding. Terraform documentation can be found [here][terraform-destroy]
```sh
terraform destroy
```
Example:
```sh
$ terraform destroy
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2847671425]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.aws_s3_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.aws_iam_policy.policy[0]: Refreshing state... [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]
module.bucket.aws_iam_role.role[0]: Refreshing state... [id=tcloud_store_access_role]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Refreshing state... [id=tcloud_store_access_role-20230325175355264400000001]
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Refreshing state... [id=fake-bucket-name]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.bucket.aws_iam_policy.policy[0] will be destroyed
  - resource "aws_iam_policy" "policy" {
      - arn         = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> null
      - description = "IAM Policy that grants Telestream Cloud permissions used to access S3 Bucket, created by terraform" -> null
      - id          = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> null
      - name        = "tcloud_store_access_policy" -> null
      - path        = "/" -> null
      - policy      = jsonencode(
            {
              - Id        = "PandaStreamBucketPolicy"
              - Statement = [
                  - {
                      - Action   = [
                          - "s3:AbortMultipartUpload",
                          - "s3:GetObjectAcl",
                          - "s3:DeleteObject",
                          - "s3:GetObject",
                          - "s3:PutObjectAcl",
                          - "s3:ListMultipartUploadParts",
                          - "s3:PutObject",
                        ]
                      - Effect   = "Allow"
                      - Resource = "arn:aws:s3:::fake-bucket-name/*"
                      - Sid      = "AllowBucketObjectsAccess0"
                    },
                  - {
                      - Action   = [
                          - "s3:GetBucketAcl",
                          - "s3:ListBucket",
                          - "s3:ListBucketMultipartUploads",
                          - "s3:GetBucketLocation",
                          - "s3:PutBucketAcl",
                          - "s3:GetBucketNotification",
                          - "s3:PutBucketNotification",
                          - "s3:GetBucketPolicy",
                          - "s3:PutBucketPolicy",
                          - "s3:DeleteBucketPolicy",
                        ]
                      - Effect   = "Allow"
                      - Resource = "arn:aws:s3:::fake-bucket-name"
                      - Sid      = "AllowBucketAccess0"
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - policy_id   = "ANPA5TRHZWO37LFU5BIKR" -> null
      - tags        = {} -> null
      - tags_all    = {} -> null
    }

  # module.bucket.aws_iam_role.role[0] will be destroyed
  - resource "aws_iam_role" "role" {
      - arn                   = "arn:aws:iam::012345678901:role/tcloud_store_access_role" -> null
      - assume_role_policy    = jsonencode(
            {
              - Statement = [
                  - {
                      - Action    = "sts:AssumeRole"
                      - Condition = {
                          - StringEquals = {
                              - "sts:ExternalId" = [
                                  - "d6eeb23adcf5e42d64c07755d82b34da",
                                ]
                            }
                        }
                      - Effect    = "Allow"
                      - Principal = {
                          - AWS = "078992246105"
                        }
                      - Sid       = "AllowTelestreamCloudAssumeRole"
                    },
                ]
              - Version   = "2012-10-17"
            }
        ) -> null
      - create_date           = "2023-03-25T17:53:54Z" -> null
      - description           = "Telestream Cloud Role used to access S3 Bucket, created by terraform" -> null
      - force_detach_policies = false -> null
      - id                    = "tcloud_store_access_role" -> null
      - managed_policy_arns   = [
          - "arn:aws:iam::012345678901:policy/tcloud_store_access_policy",
        ] -> null
      - max_session_duration  = 3600 -> null
      - name                  = "tcloud_store_access_role" -> null
      - path                  = "/" -> null
      - tags                  = {} -> null
      - tags_all              = {} -> null
      - unique_id             = "AROA5TRHZWO363XWBZPGK" -> null
    }

  # module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0] will be destroyed
  - resource "aws_iam_role_policy_attachment" "attach_policy_to_role" {
      - id         = "tcloud_store_access_role-20230325175355264400000001" -> null
      - policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> null
      - role       = "tcloud_store_access_role" -> null
    }

  # module.bucket.aws_s3_bucket.bucket[0] will be destroyed
  - resource "aws_s3_bucket" "bucket" {
      - arn                         = "arn:aws:s3:::fake-bucket-name" -> null
      - bucket                      = "fake-bucket-name" -> null
      - bucket_domain_name          = "fake-bucket-name.s3.amazonaws.com" -> null
      - bucket_regional_domain_name = "fake-bucket-name.s3.amazonaws.com" -> null
      - force_destroy               = false -> null
      - hosted_zone_id              = "Z3AQBSTGFYJSTF" -> null
      - id                          = "fake-bucket-name" -> null
      - object_lock_enabled         = false -> null
      - region                      = "us-east-1" -> null
      - request_payer               = "BucketOwner" -> null
      - tags                        = {} -> null
      - tags_all                    = {} -> null

      - grant {
          - id          = "31bf468d4036a82729c4a81a3322c4c7c236dcbd5e4b185639d3ba13825cbde8" -> null
          - permissions = [
              - "FULL_CONTROL",
            ] -> null
          - type        = "CanonicalUser" -> null
        }

      - server_side_encryption_configuration {
          - rule {
              - bucket_key_enabled = false -> null

              - apply_server_side_encryption_by_default {
                  - sse_algorithm = "AES256" -> null
                }
            }
        }

      - versioning {
          - enabled    = false -> null
          - mfa_delete = false -> null
        }
    }

  # module.bucket.aws_s3_bucket_ownership_controls.ownership[0] will be destroyed
  - resource "aws_s3_bucket_ownership_controls" "ownership" {
      - bucket = "fake-bucket-name" -> null
      - id     = "fake-bucket-name" -> null

      - rule {
          - object_ownership = "BucketOwnerEnforced" -> null
        }
    }

  # module.bucket.aws_s3_bucket_public_access_block.block_access[0] will be destroyed
  - resource "aws_s3_bucket_public_access_block" "block_access" {
      - block_public_acls       = true -> null
      - block_public_policy     = true -> null
      - bucket                  = "fake-bucket-name" -> null
      - id                      = "fake-bucket-name" -> null
      - ignore_public_acls      = true -> null
      - restrict_public_buckets = true -> null
    }

Plan: 0 to add, 0 to change, 6 to destroy.

Changes to Outputs:
  - bucket_arns    = "arn:aws:s3:::fake-bucket-name" -> null
  - bucket_names   = "fake-bucket-name" -> null
  - iam_policy_arn = "arn:aws:iam::012345678901:policy/tcloud_store_access_policy" -> null
  - iam_role_arn   = "arn:aws:iam::012345678901:role/tcloud_store_access_role" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Destroying... [id=fake-bucket-name]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Destroying... [id=fake-bucket-name]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Destroying... [id=tcloud_store_access_role-20230325175355264400000001]
module.bucket.aws_iam_role_policy_attachment.attach_policy_to_role[0]: Destruction complete after 0s
module.bucket.aws_iam_policy.policy[0]: Destroying... [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.aws_iam_role.role[0]: Destroying... [id=tcloud_store_access_role]
module.bucket.aws_s3_bucket_public_access_block.block_access[0]: Destruction complete after 0s
module.bucket.aws_s3_bucket_ownership_controls.ownership[0]: Destruction complete after 0s
module.bucket.aws_s3_bucket.bucket[0]: Destroying... [id=fake-bucket-name]
module.bucket.aws_iam_policy.policy[0]: Destruction complete after 0s
module.bucket.aws_iam_role.role[0]: Destruction complete after 1s
module.bucket.aws_s3_bucket.bucket[0]: Destruction complete after 1s

Destroy complete! Resources: 6 destroyed.
$ 
```
