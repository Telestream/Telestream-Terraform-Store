# Terraform Module: Create Buckets and Service Account No Keys
The Terraform module generates one or more GCP buckets based on the specified bucket names. It also establishes a service account that has permission to access the Buckets, but doesn't produce any keys. This approach is useful if you prefer not to store the keys in the state file and instead generate them manually in the console.

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
| <a name="output_bucket_names"></a> [bucket\_names](#output\_bucket\_names) | The name of the bucket |
