# How to Import Current Infrastructure GCP

# Table of Contents
1. [Requirements](README.md)
2. [Initialize the Directory](#initialize-the-directory)
3. [Update Terraform Module to use Existing Resource Name to be Imported](#update-terraform-module-to-use-existing-resource-name-to-be-imported)
4. [How to Import Bucket](#how-to-import-bucket)
5. [How to Import Service Account](#how-to-import-service-account)
6. [How to Import Storage Bucket IAM Binding](#how-to-import-storage-bucket-iam-binding)
7. [How to Import Storage HMAC Key](#how-to-import-storage-hmac-key)

<br />
Go into the directory with the `main.tf`

## Initialize the Directory

When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the GCP provider. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/init)

```sh
terraform init
```



Example:

```sh
$ terraform init
Initializing modules...
- bucket in github.com/Telestream/Telestream-Terraform-Store/GCP/Bucket

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/google versions matching "4.57.0"...
- Installing hashicorp/google v4.57.0...
- Installed hashicorp/google v4.57.0 (signed by HashiCorp)

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



<br />

## Update Terraform Module to use Existing Resource Name to be Imported

Copy the module in [Examples](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/GCP/Examples)directory that fits your requirements. Example module in examples will be the [Create_Buckets_And_Service_Account_With_Keysand_service_account](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/GCP/Examples/Create_Buckets_And_Service_Account_With_Keysand_service_account) module

For all resources that you want to import to be controlled by terraform, update the `main.tf` file with their existing names instead of new unique names.

```json
provider "google" {
    credentials = file("<replace/path/to/credentials/file.json>")
}
module "bucket" {
    source          = "github.com/Telestream/Telestream-Terraform-Store/GCP/Bucket"
    bucket_names    = ["<replace_with_unique_name_of_bucket>"]
    bucket_location = "<replace_with_location_of_bucket>"
    project         = "<replace_with_project_id_deploying_into>"
    service_account = {
        account_id  = "<replace_with_service_account_id_name>"
    }
}
output "bucket_names" {
  value       = module.bucket.bucket_name
  description = "The name of the bucket"  
}
output "Access_Key" {
  value       = module.bucket.key_id
  description = "an identifier for the resource with format projects/{{project}}/hmacKeys/{{access_id}}"
}
output "Secret_Key" {
  value       = module.bucket.key_secret
  description = "HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan."
  sensitive   = true
}

```



Example:

```json
provider "google" {
    credentials = file("/Users/username/.config/gcloud/application_default_credentials.json")
}
module "bucket" {
    source          = "github.com/Telestream/Telestream-Terraform-Store/GCP/Bucket"
    bucket_names    = ["fake-bucket-name-1"] 
    bucket_location = "US-EAST1"
    project         = "gcp-project-123"
    service_account = {
        account_id  = "tcloud-tf-dev-service"
    }
}
output "bucket_names" {
  value       = module.bucket.bucket_name
  description = "The name of the bucket"  
}
output "Access_Key" {
  value       = module.bucket.key_id
  description = "an identifier for the resource with format projects/{{project}}/hmacKeys/{{access_id}}"
}
output "Secret_Key" {
  value       = module.bucket.key_secret
  description = "HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan."
  sensitive      = true
}

```



<br />

## Terraform Import

Terraform can import existing infrastructure resources. This functionality lets you bring existing resources under Terraform management. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/import) This is done by using the command terraform import

## How to Import Bucket

- Storage buckets can be imported using the name or project/name

```sh
terraform import  module.bucket.google_storage_bucket.bucket[0] <bucket-name>
```



Example

```sh
$ terraform import  module.bucket.google_storage_bucket.bucket[0] fake-bucket-name-1
module.bucket.google_storage_bucket.bucket[0]: Importing from ID "fake-bucket-name-1"...
module.bucket.google_storage_bucket.bucket[0]: Import prepared!
  Prepared google_storage_bucket for import
module.bucket.google_storage_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name-1]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
```



<br />

## How to Import Service Account

- Service accounts can be imported using their URI

```sh
terraform import  module.bucket.google_service_account.service_account[0] <service-account-uri>
```



Example

```sh
$ terraform import  module.bucket.google_service_account.service_account[0] projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com
module.bucket.google_service_account.service_account[0]: Importing from ID "projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com"...
module.bucket.google_service_account.service_account[0]: Import prepared!
  Prepared google_service_account for import
module.bucket.google_service_account.service_account[0]: Refreshing state... [id=projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$
```



<br />

## How to Import Storage Bucket IAM Binding

- IAM binding imports use space-delimited identifiers: the resource in question and the role
- Role is roles/storage.admin

```sh
terraform import module.bucket.google_storage_bucket_iam_binding.binding[0]  "b/{{bucket}} roles/storage.admin"
```



Example

```sh
$ terraform import module.bucket.google_storage_bucket_iam_binding.binding[0] "b/fake-bucket-name-1 roles/storage.admin"
module.bucket.google_storage_bucket_iam_binding.binding[0]: Importing from ID "b/fake-bucket-name-1 roles/storage.admin"...
module.bucket.google_storage_bucket_iam_binding.binding[0]: Import prepared!
  Prepared google_storage_bucket_iam_binding for import
module.bucket.google_storage_bucket_iam_binding.binding[0]: Refreshing state... [id=b/fake-bucket-name-1/roles/storage.admin]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
```



<br />

## How to Import Storage HMAC Key

HmacKey can be imported using any of these accepted formats:

- terraform import google_storage_hmac_key.default projects/{{project}}/hmacKeys/{{access_id}}
- terraform import google_storage_hmac_key.default {{project}}/{{access_id}}
- terraform import google_storage_hmac_key.default {{access_id}}

```sh
terraform import module.bucket.google_storage_hmac_key.key[0] projects/{{project}}/hmacKeys/{{access_id}}
```



Example

```sh
$ terraform import module.bucket.google_storage_hmac_key.key[0] projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

$ 
```



<br />

## Terraform Apply

The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes. After approval it will create infrastructure. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/apply)

```sh
terraform apply
```
```sh
$ terraform apply
module.bucket.google_service_account.service_account[0]: Refreshing state... [id=projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com]
module.bucket.google_storage_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name-1]
module.bucket.google_storage_hmac_key.key[0]: Refreshing state... [id=projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Refreshing state... [id=b/fake-bucket-name-1/roles/storage.admin]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration and found no differences, so no changes are needed.

Apply complete! Resources: 0 added, 0 changed, 0 destroyed.

Outputs:

Access_Key = "projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID"
bucket_names = "fake-bucket-name-1"
$ 
```