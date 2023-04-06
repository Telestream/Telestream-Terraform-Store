# How to Import Current Infrastructure AWS
[terraform-init]:https://developer.hashicorp.com/terraform/cli/commands/init
[terraform-apply]:https://developer.hashicorp.com/terraform/cli/commands/apply
[terraform-import]:https://developer.hashicorp.com/terraform/cli/commands/import
[aws-examples]:https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples
[aws-example]:https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples/iam_role_access

# Table of Contents
1. [Requirements](README.md)
2. [Initialize the Directory](#initialize-the-directory)
3. [Update Module](#update-terraform-module-to-use-existing-resouce-name-to-be-imported)
4. [How to Import Bucket](#how-to-import-bucket)
5. [How to Import Role](#how-to-import-role)
6. [How to Import Policy](#how-to-import-policy)
7. [How to Import User](#how-to-import-user)

## NOTE: Make sure the aws profile has access to the resources you plan to import

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


# Update Terraform Module to use Existing Resouce Name to be Imported
Copy the module in [Examples][aws-examples] directory that fits your requirements. Example module in examples will be the [iam_role_access][aws-example] moduleiam_role_access) module
```json
provider "aws" {
    region  = "<replace-with-region-to-deploy>"
    profile = "<replace-with-aws-profile>"
}

module "bucket" {
    source       = "../../Bucket"
    bucket_names = ["<replace-with-existing-bucket-name-to-be-imported>"]
    iam_access = {
        iam_policy_name  = "<replace-with-unique-policy-name>"
        iam_role_name    = "<replace-with-unique-role-name>"
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
exmaple
```json
provider "aws" {
    region  = "us-east-1"
    profile = "dev"
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

# How to Import Bucket
Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management.Terraform documentation can be found [here][terraform-import]
* S3 bucket can be imported using the bucket name
```sh
terraform import module.bucket.aws_s3_bucket.bucket[0] <bucket-name>
```
Example
```sh
$ terraform import module.bucket.aws_s3_bucket.bucket[0] fake-bucket-name
module.bucket.aws_s3_bucket.bucket[0]: Importing from ID "fake-bucket-name"...
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.aws_s3_bucket.bucket[0]: Import prepared!
  Prepared aws_s3_bucket for import
module.bucket.aws_s3_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name]
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2635403514]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$
``` 
# How to Import Role
* IAM Roles can be imported using the role name
```sh
terraform import module.bucket.aws_iam_role.role[0] <role-name>
```
Example
```sh
$ terraform import module.bucket.aws_iam_role.role[0] tcloud_store_access_role
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2847671425]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]
module.bucket.aws_iam_role.role[0]: Importing from ID "tcloud_store_access_role"...
module.bucket.aws_iam_role.role[0]: Import prepared!
  Prepared aws_iam_role for import
module.bucket.aws_iam_role.role[0]: Refreshing state... [id=tcloud_store_access_role]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
``` 
# How to Import Policy
* IAM Policies can be imported using the arn
```sh
terraform import module.bucket.aws_iam_policy.policy[0] <policy-arn>
```
Example
```sh
$ terraform import module.bucket.aws_iam_policy.policy[0] arn:aws:iam::012345678901:policy/tcloud_store_access_policy
module.bucket.data.aws_iam_policy_document.assume_role[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2847671425]
module.bucket.data.aws_iam_policy_document.assume_role[0]: Read complete after 0s [id=3298468559]
module.bucket.aws_iam_policy.policy[0]: Importing from ID "arn:aws:iam::012345678901:policy/tcloud_store_access_policy"...
module.bucket.aws_iam_policy.policy[0]: Import prepared!
  Prepared aws_iam_policy for import
module.bucket.aws_iam_policy.policy[0]: Refreshing state... [id=arn:aws:iam::012345678901:policy/tcloud_store_access_policy]
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Reading...
module.bucket.data.aws_iam_policy_document.assume_role_combined[0]: Read complete after 0s [id=1029124481]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
``` 
# How to Import User
* IAM Users can be imported using the name
## NOTE access keys can not be imported into terraform so new keys will be generated after running terrafrom apply after importing, but will not delete the existing keys
```sh
terraform import module.bucket.aws_iam_user.user[0] <user-name>
```
Example
```sh
$ terraform import module.bucket.aws_iam_user.user[0] tcloud_store_access_user
module.bucket.aws_iam_user.user[0]: Importing from ID "tcloud_store_access_user"...
module.bucket.aws_iam_user.user[0]: Import prepared!
  Prepared aws_iam_user for import
module.bucket.aws_iam_user.user[0]: Refreshing state... [id=tcloud_store_access_user]
module.bucket.data.aws_iam_policy_document.policy[0]: Reading...
module.bucket.data.aws_iam_policy_document.policy[0]: Read complete after 0s [id=2847671425]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
```
# Terraform Apply
The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes. After approval it will create infrastructure. Terraform documentation can be found [here][terraform-apply]
```sh
terraform apply
```