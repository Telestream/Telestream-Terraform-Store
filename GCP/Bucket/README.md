## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_google"></a> [google](#requirement\_google) | 4.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_google"></a> [google](#provider\_google) | 4.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [google_service_account.service_account](https://registry.terraform.io/providers/hashicorp/google/4.57.0/docs/resources/service_account) | resource |
| [google_storage_bucket.bucket](https://registry.terraform.io/providers/hashicorp/google/4.57.0/docs/resources/storage_bucket) | resource |
| [google_storage_bucket_iam_binding.binding](https://registry.terraform.io/providers/hashicorp/google/4.57.0/docs/resources/storage_bucket_iam_binding) | resource |
| [google_storage_hmac_key.key](https://registry.terraform.io/providers/hashicorp/google/4.57.0/docs/resources/storage_hmac_key) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket_location"></a> [bucket\_location](#input\_bucket\_location) | (Required) The GCS location(https://cloud.google.com/storage/docs/locations). | `string` | n/a | yes |
| <a name="input_bucket_names"></a> [bucket\_names](#input\_bucket\_names) | The list of names for the buckets. Must be lowercase and must be between 3 (min) and 63 (max) characters long, go to link for bucket name rules https://cloud.google.com/storage/docs/buckets#:~:text=by%2Dstep%20guide.-,Bucket%20names,Spaces%20are%20not%20allowed. | `list(string)` | `[]` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | (Optional) default true creates the GCP bucket if false does not create any resources | `bool` | `true` | no |
| <a name="input_force_destroy"></a> [force\_destroy](#input\_force\_destroy) | (Optional, Default: false) When deleting a bucket, this boolean option will delete all contained objects. If you try to delete a bucket that contains objects, Terraform will fail that run. | `bool` | `false` | no |
| <a name="input_project"></a> [project](#input\_project) | (Optional) The ID of the project in which the resource belongs. If it is not provided, the provider project is used. | `string` | `null` | no |
| <a name="input_public_access_prevention"></a> [public\_access\_prevention](#input\_public\_access\_prevention) | (Optional, default enforced) Prevents public access to a bucket. Acceptable values are inherited or enforced. If inherited, the bucket uses public access prevention. only if the bucket is subject to the public access prevention organization policy constraint | `string` | `"enforced"` | no |
| <a name="input_service_account"></a> [service\_account](#input\_service\_account) | service\_account\_account = {<br>          create\_service\_account      :"(Optional, Default true) if set to true will create a service account that has access to buckets created"<br>          create\_service\_account\_key  :"(Optional, Default true) If set to true will create keys that telestream can use to access bucket"<br>          account\_id                  :"(Required) The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression [a-z]([-a-z0-9]*[a-z0-9]) to comply with RFC1035. Changing this forces a new service account to be created."<br>          display\_name                :"(Optional) The display name for the service account. Can be updated without creating a new resource."<br>          description                 :"(Optional) A text description of the service account. Must be less than or equal to 256 UTF-8 bytes."<br>          disabled                    :"(Optional, default false) Whether a service account is disabled or not. Defaults to false. This field has no effect during creation. Must be set after creation to disable a service account."<br>          key\_state                   :"(Optional, default ACTIVE) The state of the key. Can be set to one of ACTIVE, INACTIVE. Default value is ACTIVE. Possible values are ACTIVE and INACTIVE."<br>        } | <pre>object({<br>        create_service_account      = optional(bool, true)<br>        create_service_account_key  = optional(bool, true)<br>        //google_service_account<br>        account_id                  = optional(string)<br>        display_name                = optional(string)<br>        description                 = optional(string,"Service Account used to allow telestream cloud access the azure buckets")<br>        disabled                    = optional(bool,false)<br>        //google_storage_hmac_key<br>        key_state                   = optional(string, "ACTIVE")<br>      })</pre> | n/a | yes |
| <a name="input_storage_class"></a> [storage\_class](#input\_storage\_class) | (Optional, Default: 'STANDARD') The Storage Class of the new bucket. Supported values include: STANDARD, MULTI\_REGIONAL, REGIONAL, NEARLINE, COLDLINE, ARCHIVE. | `string` | `"STANDARD"` | no |
| <a name="input_uniform_bucket_level_access"></a> [uniform\_bucket\_level\_access](#input\_uniform\_bucket\_level\_access) | (Optional, Default: false) Enables Uniform bucket-level access access to a bucket, false sets bucket to Fine-grained for access control which is required by telestream | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bucket_name"></a> [bucket\_name](#output\_bucket\_name) | The name of the bucket |
| <a name="output_bucket_self_link"></a> [bucket\_self\_link](#output\_bucket\_self\_link) | The URI of the created resource. |
| <a name="output_bucket_url"></a> [bucket\_url](#output\_bucket\_url) | The base URL of the bucket, in the format gs://<bucket-name>. |
| <a name="output_google_storage_bucket_iam_etag"></a> [google\_storage\_bucket\_iam\_etag](#output\_google\_storage\_bucket\_iam\_etag) | The etag of the IAM policy. |
| <a name="output_key_access_id"></a> [key\_access\_id](#output\_key\_access\_id) | The access ID of the HMAC Key. |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | an identifier for the resource with format projects/{{project}}/hmacKeys/{{access\_id}} |
| <a name="output_key_secret"></a> [key\_secret](#output\_key\_secret) | HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan. |
| <a name="output_key_time_created"></a> [key\_time\_created](#output\_key\_time\_created) | The creation time of the HMAC key in RFC 3339 format. |
| <a name="output_key_updated"></a> [key\_updated](#output\_key\_updated) | The last modification time of the HMAC key metadata in RFC 3339 format. |
| <a name="output_service_account_email"></a> [service\_account\_email](#output\_service\_account\_email) | The e-mail address of the service account. This value should be referenced from any google\_iam\_policy data sources that would grant the service account privileges. |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | an identifier for the resource with format projects/{{project}}/serviceAccounts/{{email}} |
| <a name="output_service_account_member"></a> [service\_account\_member](#output\_service\_account\_member) | The Identity of the service account in the form serviceAccount:{email}. This value is often used to refer to the service account in order to grant IAM permissions. |
| <a name="output_service_account_name"></a> [service\_account\_name](#output\_service\_account\_name) | The fully-qualified name of the service account. |
| <a name="output_service_account_unique_id"></a> [service\_account\_unique\_id](#output\_service\_account\_unique\_id) | The unique id of the service account. |
