# Terraform Module: Create Buckets and Service Account With Keys
The Terraform module generates one or more GCP buckets based on the provided bucket names. It also creates a service account that has access to the Buckets, as well as HMAC Keys with access/secret.

## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_bucket"></a> [bucket](#module\_bucket) | github.com/Telestream/Telestream-Terraform-Store/GCP/Bucket | n/a |

## Resources

No resources.

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_Access_Key"></a> [Access\_Key](#output\_Access\_Key) | an identifier for the resource with format projects/{{project}}/hmacKeys/{{access\_id}} |
| <a name="output_Secret_Key"></a> [Secret\_Key](#output\_Secret\_Key) | HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan. |
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | The name of the bucket |
