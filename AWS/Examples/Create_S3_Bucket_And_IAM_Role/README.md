# Terraform Module: Create S3 Bucket and IAM Role
This Terraform module creates one or more Amazon S3 buckets based on the inputted bucket names. Each bucket name must be unique across all AWS accounts, a bucket name cannot be used by another AWS account due to the global nature of Amazon S3. The created buckets are all deployed in the same region as specified in the AWS provider's region field and in the AWS account defined by the AWS profile. Additionally, the module creates an AWS IAM role and IAM Policy with access to all the created S3 buckets with permissions required by the stores. 

The IAM role created by the module requires a AWS account unique name specified by the iam_role_name input field. If the provided name is already taken, the iam_role_name_prefix input field can be used to add random numbers to the end of the inputted value to ensure uniqueness. For instance, if iam_role_name_prefix is set to tcloud_store_access_role, the outputted IAM role name would be tcloud_store_access_role20230421161202461800000001.

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
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | Amazon Resource Name (ARN) specifying the role. |
