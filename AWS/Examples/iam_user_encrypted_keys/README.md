## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket | n/a |

## Resources

| Name | Type |
|------|------|
| [local_file.pgp_key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_arns"></a> [bucket\_arns](#output\_bucket\_arns) | list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]. |
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | list of the of names of the buckets created by terraform |
| <a name="output_iam_access_key_encrypted_secret"></a> [iam\_access\_key\_encrypted\_secret](#output\_iam\_access\_key\_encrypted\_secret) | Encrypted secret, base64 encoded using key provided |
| <a name="output_iam_access_key_encrypted_secret_key_decrypt_command"></a> [iam\_access\_key\_encrypted\_secret\_key\_decrypt\_command](#output\_iam\_access\_key\_encrypted\_secret\_key\_decrypt\_command) | Decrypt access secret key command |
| <a name="output_iam_access_key_id"></a> [iam\_access\_key\_id](#output\_iam\_access\_key\_id) | Access key ID. |
| <a name="output_iam_access_key_pgp_key"></a> [iam\_access\_key\_pgp\_key](#output\_iam\_access\_key\_pgp\_key) | pgp\_key provided to encrypt secret key |
| <a name="output_iam_policy_arn"></a> [iam\_policy\_arn](#output\_iam\_policy\_arn) | The ARN assigned by AWS to this policy. |
| <a name="output_iam_user_arn"></a> [iam\_user\_arn](#output\_iam\_user\_arn) | The ARN assigned by AWS for this user. |
