# How to Update Infrastructure GCP
# NOTE if changing the bucket names, terraform will attempt to delete the existing buckets and all objects inside, so be careful and read terraform plan on what will be destroyed

Terraform Build Infrastructure Documentation can be found [here](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build)

# Table of Contents
1. [Requirements](README.md)
3. [Update values in module](#update-values-in-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)

<br />

Go into the directory with the `main.tf` and `terraform.tfstate` to run the terraform destroy command.

## Update values in module

To update values after deployed, just change values in main.tf to new values you want. Example changing the policy, role name, or bucket names. Changing bucket name will have terraform destroy old buckets and everything in it and create a new bucket, this will result of losing all objects in the GCP bucket. 

<br /> 
Example bellow will update the GCP bucket names.

Original:

```json
provider "google" {
    credentials = file("path/to/credentials/file.json")
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



Update:

```json
provider "google" {
    credentials = file("/Users/username/.config/gcloud/application_default_credentials.json")
}
module "bucket" {
    source          = "github.com/Telestream/Telestream-Terraform-Store/GCP/Bucket"
    bucket_names    = ["fake-bucket-name-1-new"]
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

## Terraform Plan

The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. The plan command alone does not actually carry out the proposed changes. You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/plan)

```sh
terraform plan
```



Example:

```sh
$ terraform plan
module.bucket.google_storage_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name-1]
module.bucket.google_service_account.service_account[0]: Refreshing state... [id=projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com]
module.bucket.google_storage_hmac_key.key[0]: Refreshing state... [id=projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Refreshing state... [id=b/fake-bucket-name-1/roles/storage.admin]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.bucket.google_storage_bucket.bucket[0] has changed
  ~ resource "google_storage_bucket" "bucket" {
        id                          = "fake-bucket-name-1"
      + labels                      = {}
        name                        = "fake-bucket-name-1"
        # (10 unchanged attributes hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.bucket.google_storage_bucket.bucket[0] must be replaced
-/+ resource "google_storage_bucket" "bucket" {
      - default_event_based_hold    = false -> null
      ~ id                          = "fake-bucket-name-1" -> (known after apply)
      - labels                      = {} -> null
      ~ name                        = "fake-bucket-name-1" -> "fake-bucket-name-1-new" # forces replacement
      - requester_pays              = false -> null
      ~ self_link                   = "https://www.googleapis.com/storage/v1/b/fake-bucket-name-1" -> (known after apply)
      ~ url                         = "gs://fake-bucket-name-1" -> (known after apply)
        # (6 unchanged attributes hidden)

      + versioning {
          + enabled = (known after apply)
        }

      + website {
          + main_page_suffix = (known after apply)
          + not_found_page   = (known after apply)
        }
    }

  # module.bucket.google_storage_bucket_iam_binding.binding[0] must be replaced
-/+ resource "google_storage_bucket_iam_binding" "binding" {
      ~ bucket  = "b/fake-bucket-name-1" -> "fake-bucket-name-1-new" # forces replacement
      ~ etag    = "CAI=" -> (known after apply)
      ~ id      = "b/fake-bucket-name-1/roles/storage.admin" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

Plan: 2 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  ~ bucket_names = "fake-bucket-name-1" -> "fake-bucket-name-1-new"

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
$ 
```



<br />

## Create Infrastructure

The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, enter yes to approve. After approval it will create infrastructure. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/apply)

```sh
terraform apply
```



Example:

```sh
$ terraform apply
module.bucket.google_service_account.service_account[0]: Refreshing state... [id=projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com]
module.bucket.google_storage_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name-1]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Refreshing state... [id=b/fake-bucket-name-1/roles/storage.admin]
module.bucket.google_storage_hmac_key.key[0]: Refreshing state... [id=projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]

Note: Objects have changed outside of Terraform

Terraform detected the following changes made outside of Terraform since the last "terraform apply" which may have affected this plan:

  # module.bucket.google_storage_bucket.bucket[0] has changed
  ~ resource "google_storage_bucket" "bucket" {
        id                          = "fake-bucket-name-1"
      + labels                      = {}
        name                        = "fake-bucket-name-1"
        # (10 unchanged attributes hidden)
    }


Unless you have made equivalent changes to your configuration, or ignored the relevant attributes using ignore_changes, the following plan may include actions to undo or respond to these changes.

───────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
-/+ destroy and then create replacement

Terraform will perform the following actions:

  # module.bucket.google_storage_bucket.bucket[0] must be replaced
-/+ resource "google_storage_bucket" "bucket" {
      - default_event_based_hold    = false -> null
      ~ id                          = "fake-bucket-name-1" -> (known after apply)
      - labels                      = {} -> null
      ~ name                        = "fake-bucket-name-1" -> "fake-bucket-name-1-new" # forces replacement
      - requester_pays              = false -> null
      ~ self_link                   = "https://www.googleapis.com/storage/v1/b/fake-bucket-name-1" -> (known after apply)
      ~ url                         = "gs://fake-bucket-name-1" -> (known after apply)
        # (6 unchanged attributes hidden)

      + versioning {
          + enabled = (known after apply)
        }

      + website {
          + main_page_suffix = (known after apply)
          + not_found_page   = (known after apply)
        }
    }

  # module.bucket.google_storage_bucket_iam_binding.binding[0] must be replaced
-/+ resource "google_storage_bucket_iam_binding" "binding" {
      ~ bucket  = "b/fake-bucket-name-1" -> "fake-bucket-name-1-new" # forces replacement
      ~ etag    = "CAI=" -> (known after apply)
      ~ id      = "b/fake-bucket-name-1/roles/storage.admin" -> (known after apply)
        # (2 unchanged attributes hidden)
    }

Plan: 2 to add, 0 to change, 2 to destroy.

Changes to Outputs:
  ~ bucket_names = "fake-bucket-name-1" -> "fake-bucket-name-1-new"

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.bucket.google_storage_bucket_iam_binding.binding[0]: Destroying... [id=b/fake-bucket-name-1/roles/storage.admin]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Destruction complete after 4s
module.bucket.google_storage_bucket.bucket[0]: Destroying... [id=fake-bucket-name-1]
module.bucket.google_storage_bucket.bucket[0]: Destruction complete after 1s
module.bucket.google_storage_bucket.bucket[0]: Creating...
module.bucket.google_storage_bucket.bucket[0]: Creation complete after 0s [id=fake-bucket-name-1-new]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Creating...
module.bucket.google_storage_bucket_iam_binding.binding[0]: Creation complete after 5s [id=b/fake-bucket-name-1-new/roles/storage.admin]

Apply complete! Resources: 2 added, 0 changed, 2 destroyed.

Outputs:

Access_Key = "projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID"
Secret_Key = <sensitive>
bucket_names = "fake-bucket-name-1-new"
Locals-MBP:Store kevin.travers$ 
```