# How to Deploy Infrastructure
Terraform Build Infrastructure Documentation can be found [here][terraform-build-infrastructure]

# Table of Contents
1. [Requirements](README.md)
2. [Copy Module](#copy-a-module)
3. [Replace values in module](#replace-values-in-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build
[terraform-init]:https://developer.hashicorp.com/terraform/cli/commands/init
[terraform-plan]:https://developer.hashicorp.com/terraform/cli/commands/plan
[terraform-apply]:https://developer.hashicorp.com/terraform/cli/commands/apply

# Copy a module
Copy the module in examples directory that fits your requirements. Example module in examples will be the create_bucket_and_service_account module
# Replace values in module
Original:
```json
provider "google" {
    credentials = file("/path/to/credentials/file.json")
}
//minium needed to create bucket
module "bucket" {
    source          = "../../Bucket"
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
    credentials = file("/path/to/credentials/file.json")
}
//minium needed to create bucket
module "bucket" {
    source          = "../../Bucket"
    //enabled         = true
    bucket_names    = ["fake-bucket-name-1"]
   // storage_class   = "STANDARD" 
    bucket_location = "US-EAST1"
    project         = "cloud-engineering-123"
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
# Initialize the Directory
When you create a new configuration — or check out an existing configuration from version control — you need to initialize the directory with terraform init.

Initializing a configuration directory downloads and installs the providers defined in the configuration, which in this case is the GCP provider. Terraform documentation can be found [here][terraform-init]
```sh
terraform init
```
Example:
```sh
$ terraform init
Initializing modules...
- bucket in ../Bucket

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
# Terraform Plan
The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. The plan command alone does not actually carry out the proposed changes. You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review. Terraform documentation can be found [here][terraform-plan]
```sh
terraform plan
```
Example:
```sh
$ terraform plan

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.bucket.google_service_account.service_account[0] will be created
  + resource "google_service_account" "service_account" {
      + account_id  = "tcloud-tf-dev-service"
      + description = "Service Account used to allow telestream cloud access the azure buckets"
      + disabled    = false
      + email       = (known after apply)
      + id          = (known after apply)
      + member      = (known after apply)
      + name        = (known after apply)
      + project     = "cloud-engineering-123"
      + unique_id   = (known after apply)
    }

  # module.bucket.google_storage_bucket.bucket[0] will be created
  + resource "google_storage_bucket" "bucket" {
      + force_destroy               = false
      + id                          = (known after apply)
      + location                    = "US-EAST1"
      + name                        = "fake-bucket-name-1"
      + project                     = "cloud-engineering-123"
      + public_access_prevention    = "enforced"
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = false
      + url                         = (known after apply)

      + versioning {
          + enabled = (known after apply)
        }

      + website {
          + main_page_suffix = (known after apply)
          + not_found_page   = (known after apply)
        }
    }

  # module.bucket.google_storage_bucket_iam_binding.binding[0] will be created
  + resource "google_storage_bucket_iam_binding" "binding" {
      + bucket  = "fake-bucket-name-1"
      + etag    = (known after apply)
      + id      = (known after apply)
      + members = (known after apply)
      + role    = "roles/storage.admin"
    }

  # module.bucket.google_storage_hmac_key.key[0] will be created
  + resource "google_storage_hmac_key" "key" {
      + access_id             = (known after apply)
      + id                    = (known after apply)
      + project               = "cloud-engineering-123"
      + secret                = (sensitive value)
      + service_account_email = (known after apply)
      + state                 = "ACTIVE"
      + time_created          = (known after apply)
      + updated               = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + Access_Key   = (known after apply)
  + Secret_Key   = (sensitive value)
  + bucket_names = "fake-bucket-name-1"

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
$ 
```
# Create Infrastructure
The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, enter yes to approve. After approval it will create infrastructure. Terraform documentation can be found [here][terraform-apply]
```sh
terraform apply
```
Example:
```sh
$ terraform apply

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.bucket.google_service_account.service_account[0] will be created
  + resource "google_service_account" "service_account" {
      + account_id  = "tcloud-tf-dev-service"
      + description = "Service Account used to allow telestream cloud access the azure buckets"
      + disabled    = false
      + email       = (known after apply)
      + id          = (known after apply)
      + member      = (known after apply)
      + name        = (known after apply)
      + project     = "cloud-engineering-123"
      + unique_id   = (known after apply)
    }

  # module.bucket.google_storage_bucket.bucket[0] will be created
  + resource "google_storage_bucket" "bucket" {
      + force_destroy               = false
      + id                          = (known after apply)
      + location                    = "US-EAST1"
      + name                        = "fake-bucket-name-1"
      + project                     = "cloud-engineering-123"
      + public_access_prevention    = "enforced"
      + self_link                   = (known after apply)
      + storage_class               = "STANDARD"
      + uniform_bucket_level_access = false
      + url                         = (known after apply)

      + versioning {
          + enabled = (known after apply)
        }

      + website {
          + main_page_suffix = (known after apply)
          + not_found_page   = (known after apply)
        }
    }

  # module.bucket.google_storage_bucket_iam_binding.binding[0] will be created
  + resource "google_storage_bucket_iam_binding" "binding" {
      + bucket  = "fake-bucket-name-1"
      + etag    = (known after apply)
      + id      = (known after apply)
      + members = (known after apply)
      + role    = "roles/storage.admin"
    }

  # module.bucket.google_storage_hmac_key.key[0] will be created
  + resource "google_storage_hmac_key" "key" {
      + access_id             = (known after apply)
      + id                    = (known after apply)
      + project               = "cloud-engineering-123"
      + secret                = (sensitive value)
      + service_account_email = (known after apply)
      + state                 = "ACTIVE"
      + time_created          = (known after apply)
      + updated               = (known after apply)
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + Access_Key   = (known after apply)
  + Secret_Key   = (sensitive value)
  + bucket_names = "fake-bucket-name-1"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.bucket.google_service_account.service_account[0]: Creating...
module.bucket.google_storage_bucket.bucket[0]: Creating...
module.bucket.google_storage_bucket.bucket[0]: Creation complete after 0s [id=fake-bucket-name-1]
module.bucket.google_service_account.service_account[0]: Creation complete after 1s [id=projects/cloud-engineering-123/serviceAccounts/tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com]
module.bucket.google_storage_hmac_key.key[0]: Creating...
module.bucket.google_storage_bucket_iam_binding.binding[0]: Creating...
module.bucket.google_storage_hmac_key.key[0]: Creation complete after 0s [id=projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Creation complete after 4s [id=b/fake-bucket-name-1/roles/storage.admin]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

Access_Key = "projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID"
Secret_Key = <sensitive>
bucket_names = "fake-bucket-name-1"
$ 
```