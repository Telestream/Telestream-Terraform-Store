# Terraform Module: Create S3 Bucket and IAM Role
This Terraform module creates one or more Amazon S3 buckets based on the inputted bucket names. Each bucket name must be unique across all AWS accounts, a bucket name cannot be used by another AWS account due to the global nature of Amazon S3. The created buckets are all deployed in the same region as specified in the AWS provider's region field and in the AWS account defined by the AWS profile. Additionally, the module creates a seperate AWS IAM role and IAM Policy for each S3 bucket created from the list. Each role will have access to one of the created S3 buckets with permissions required by the stores.

The IAM role created by the module requires a AWS account unique name specified by the iam_role_name input field. Since this is creating multiple roles the iam_role_name_prefix input field should be used to add random numbers to the end of the inputted value to ensure uniqueness. For instance, if iam_role_name_prefix is set to tcloud_store_access_role, the outputted IAM role name would be tcloud_store_access_role20230421161202461800000001.

The IAM policy created by the module requires a AWS account unique name specified by the iam_policy_name input field. Since this is creating multiple roles the iam_policy_name_prefix input field should  be used to add random characters to the end of the inputted value to ensure uniqueness. For instance, if iam_policy_name_prefix is set to tcloud_store_access_policy, the outputted IAM policy name would be tcloud_store_access_policy20230421161202462100000002.

A output named iam_role_arn_bucket_map will show which role has access to which bucket, with a bucket name and role arn key pair.
```json
iam_role_arn_bucket_map = tomap({
  "tcloud-store-prod-bucket-sandbox-1" = "arn:aws:iam::417606358165:role/tcloud_store_access_role20230421184505816500000002"
  "tcloud-store-prod-bucket-sandbox-2" = "arn:aws:iam::417606358165:role/tcloud_store_access_role20230421184505816800000003"
  "tcloud-store-prod-bucket-sandbox-3" = "arn:aws:iam::417606358165:role/tcloud_store_access_role20230421184505817400000004"
})
```
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
