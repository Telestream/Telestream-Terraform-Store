
# How to Destroy Infrastructure
Terraform Build Infrastructure Documentation can be found [here][terraform-build-infrastructure]

# Table of Contents
1. [Requirements](README.md)
2. [Initialize the Directory](#initialize-the-directory)
3. [Destroy Infrastructure](#destroy-infrastructure)

[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build
[terraform-init]:https://developer.hashicorp.com/terraform/cli/commands/init
[terraform-destroy]:https://developer.hashicorp.com/terraform/cli/commands/destroy

# Initialize the Directory
```sh
terraform init
```
# Destroy Infrastructure
The terraform destroy command destroys all of the resources being managed by the current working directory and workspace, using state data to determine which real world objects correspond to managed resources. Like terraform apply, it asks for confirmation before proceeding. Terraform documentation can be found [here][terraform-destroy]
```sh
terraform destroy
```
Example:
```sh
$ terraform destroy
module.bucket.google_service_account.service_account[0]: Refreshing state... [id=projects/cloud-engineering-123/serviceAccounts/tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com]
module.bucket.google_storage_bucket.bucket[0]: Refreshing state... [id=fake-bucket-name-1]
module.bucket.google_storage_hmac_key.key[0]: Refreshing state... [id=projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Refreshing state... [id=b/fake-bucket-name-1/roles/storage.admin]

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  - destroy

Terraform will perform the following actions:

  # module.bucket.google_service_account.service_account[0] will be destroyed
  - resource "google_service_account" "service_account" {
      - account_id  = "tcloud-tf-dev-service" -> null
      - description = "Service Account used to allow telestream cloud access the azure buckets" -> null
      - disabled    = false -> null
      - email       = "tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com" -> null
      - id          = "projects/cloud-engineering-123/serviceAccounts/tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com" -> null
      - member      = "serviceAccount:tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com" -> null
      - name        = "projects/cloud-engineering-123/serviceAccounts/tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com" -> null
      - project     = "cloud-engineering-123" -> null
      - unique_id   = "107999680400370368728" -> null
    }

  # module.bucket.google_storage_bucket.bucket[0] will be destroyed
  - resource "google_storage_bucket" "bucket" {
      - default_event_based_hold    = false -> null
      - force_destroy               = false -> null
      - id                          = "fake-bucket-name-1" -> null
      - labels                      = {} -> null
      - location                    = "US-EAST1" -> null
      - name                        = "fake-bucket-name-1" -> null
      - project                     = "cloud-engineering-123" -> null
      - public_access_prevention    = "enforced" -> null
      - requester_pays              = false -> null
      - self_link                   = "https://www.googleapis.com/storage/v1/b/fake-bucket-name-1" -> null
      - storage_class               = "STANDARD" -> null
      - uniform_bucket_level_access = false -> null
      - url                         = "gs://fake-bucket-name-1" -> null
    }

  # module.bucket.google_storage_bucket_iam_binding.binding[0] will be destroyed
  - resource "google_storage_bucket_iam_binding" "binding" {
      - bucket  = "b/fake-bucket-name-1" -> null
      - etag    = "CAI=" -> null
      - id      = "b/fake-bucket-name-1/roles/storage.admin" -> null
      - members = [
          - "serviceAccount:tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com",
        ] -> null
      - role    = "roles/storage.admin" -> null
    }

  # module.bucket.google_storage_hmac_key.key[0] will be destroyed
  - resource "google_storage_hmac_key" "key" {
      - access_id             = "GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID" -> null
      - id                    = "projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID" -> null
      - project               = "cloud-engineering-123" -> null
      - secret                = (sensitive value)
      - service_account_email = "tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com" -> null
      - state                 = "ACTIVE" -> null
      - time_created          = "2023-04-04T14:40:12.792Z" -> null
      - updated               = "2023-04-04T14:40:12.792Z" -> null
    }

Plan: 0 to add, 0 to change, 4 to destroy.

Changes to Outputs:
  - Access_Key   = "projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID" -> null
  - Secret_Key   = (sensitive value)
  - bucket_names = "fake-bucket-name-1" -> null

Do you really want to destroy all resources?
  Terraform will destroy all your managed infrastructure, as shown above.
  There is no undo. Only 'yes' will be accepted to confirm.

  Enter a value: yes

module.bucket.google_storage_bucket_iam_binding.binding[0]: Destroying... [id=b/fake-bucket-name-1/roles/storage.admin]
module.bucket.google_storage_hmac_key.key[0]: Destroying... [id=projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]
module.bucket.google_storage_hmac_key.key[0]: Destruction complete after 2s
module.bucket.google_storage_bucket_iam_binding.binding[0]: Destruction complete after 5s
module.bucket.google_service_account.service_account[0]: Destroying... [id=projects/cloud-engineering-123/serviceAccounts/tcloud-tf-dev-service@cloud-engineering-123.iam.gserviceaccount.com]
module.bucket.google_storage_bucket.bucket[0]: Destroying... [id=fake-bucket-name-1]
module.bucket.google_storage_bucket.bucket[0]: Destruction complete after 0s
module.bucket.google_service_account.service_account[0]: Destruction complete after 0s

Destroy complete! Resources: 4 destroyed.
$ 
```
