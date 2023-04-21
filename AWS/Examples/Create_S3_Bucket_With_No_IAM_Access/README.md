# Terraform Module: Create S3 Bucket and IAM Role
This Terraform module creates one or more Amazon S3 buckets based on the inputted bucket names. Each bucket name must be unique across all AWS accounts, a bucket name cannot be used by another AWS account due to the global nature of Amazon S3. The created buckets are all deployed in the same region as specified in the AWS provider's region field and in the AWS account defined by the AWS profile.
This does not create IAM Role or IAM User with AccessKey/SecretKey. Since AWS Stores require AccessKey/SecretKey or IAM Role to access the S3 Bucket to create the store, then the creation of these permissions is up to you.

Use if you want to hanlde IAM creation seperatly from this terraform module.

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

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_names"></a> [bucket\_names](#input\_bucket\_names) | n/a | `list(string)` | <pre>[<br>  "<replace_with_unique_name_of_bucket>",<br>  "<replace_with_unique_name_of_bucket>",<br>  "<replace_with_unique_name_of_bucket>"<br>]</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arns"></a> [bucket\_arns](#output\_bucket\_arns) | list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]. |
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | list of the of names of the buckets created by terraform |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy. |
| <a name="output_iam_role_arn"></a> [iam\_role\_arn](#output\_iam\_role\_arn) | Amazon Resource Name (ARN) specifying the role. |
| <a name="output_iam_role_arn_bucket_map"></a> [iam\_role\_arn\_bucket\_map](#output\_iam\_role\_arn\_bucket\_map) | Maping the bucket to the iam role that has access to the bucket |

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
