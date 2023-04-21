# Terraform Module: Create S3 Bucket and IAM User
This Terraform module creates one or more Amazon S3 buckets based on the inputted bucket names. Each bucket name must be unique across all AWS accounts, a bucket name cannot be used by another AWS account due to the global nature of Amazon S3. The created buckets are all deployed in the same region as specified in the AWS provider's region field and in the AWS account defined by the AWS profile. Additionally, the module creates an AWS IAM User with access/secret keys and IAM Policy with access to all the created S3 buckets with permissions required by the stores.

The IAM User created by the module requires a AWS account unique name specified by the iam_role_name input field. 

The IAM policy created by the module requires a AWS account unique name specified by the iam_policy_name input field. If the provided name is already taken, the iam_policy_name_prefix input field can be used to add random characters to the end of the inputted value to ensure uniqueness. For instance, if iam_policy_name_prefix is set to tcloud_store_access_policy, the outputted IAM policy name would be tcloud_store_access_policy20230421161202462100000002.
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arns"></a> [bucket\_arns](#output\_bucket\_arns) | list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]. |
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | list of the of names of the buckets created by terraform |
| <a name="output_iam_access_key_id"></a> [iam\_access\_key\_id](#output\_iam\_access\_key\_id) | Access key ID. |
| <a name="output_iam_access_key_secret"></a> [iam\_access\_key\_secret](#output\_iam\_access\_key\_secret) | Secret access key. |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy. |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | The ARN assigned by AWS for this user. |
