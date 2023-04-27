# How to Deploy Infrastructure GCP
Terraform Build Infrastructure Documentation can be found [here](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build)

# Table of Contents
1. [Requirements](README.md)
2. [Select Example module](#select-example-module)
3. [Copy a module](#copy-a-module)
4. [Creating a Terraform Environment Deployment Folder](#creating-a-terraform-environment-deployment-folder)
5. [Replace values in example module](#replace-values-in-example-module)
4. [Initialize the Directory](#initialize-the-directory)
5. [Terraform Plan](#terraform-plan)
6. [Create Infrastructure](#create-infrastructure)
<br />

## Select Example module

Pick an [Example](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/GCP/Examples) module that best fits your requirements, the examples bellow will be using [Create_Buckets_And_Service_Account_With_Keysand_service_account](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/GCP/Examples/Create_Buckets_And_Service_Account_With_Keysand_service_account).

## Copy a module

Copy the main.tf in the[Examples](https://github.com/Telestream/Telestream-Terraform-Store/tree/main/AWS/Examples) that you want to use in a safe and secure place since terraform will generate a [state](https://developer.hashicorp.com/terraform/language/state)file. The Terraform state file is a JSON file that contains the current state of the infrastructure resources managed by Terraform. It keeps track of the resources that Terraform created, updated, or destroyed during the last run. The Terraform state file is crucial because it enables Terraform to perform operations like update, destroy, or create resources based on the current state. Without the state file, Terraform would not know which resources to update, destroy or create, making infrastructure management difficult.

<br />

In addition, the Terraform state file allows for collaborative infrastructure management. When multiple team members work on the same infrastructure, the state file serves as a shared record of the current infrastructure state. This allows team members to collaborate effectively and avoid conflicts.

## Creating a Terraform Environment Deployment Folder

To create a new Terraform environment deployment, follow the steps below:

1. Create a new folder and name it `terraform`
2. Inside the `terraform` folder, create another folder named after the environment you want to deploy to (e.g., sandbox, dev, staging, or prod).
3. Inside the environment folder, create a new folder to store the Terraform main. The folder name should be descriptive of what the Terraform code does. For example, if you are creating S3 buckets in the cloud, the folder name could be `tcloud-gcp-buckets`.
4. Best practices name the terraform file as `main.tf`. 

By following the above steps, you can create a new Terraform environment deployment folder and organize your Terraform code effectively. Keeping Terraform separate for different environments is a good practice that helps prevent any conflicts and simplifies the deployment process.

<br />

## Replace values in example module

Below is the example `main.tf` for creating a list of GCP buckets and GCP Service account that has access to buckets created.

Original:

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



## Use GCloud Authentication in Modules

To enable terraform to access your GCP environment, Authenticate using User [Application Default Credentials ("ADCs")](https://cloud.google.com/sdk/gcloud/reference/auth/application-default) as a primary authentication method. 

<br />

Command:

```sh
gcloud auth application-default login
```



<br />

Example:

```sh
$ gcloud auth application-default login
Your browser has been opened to visit:

    https://accounts.google.com/o/oauth2/auth?response_type=code&client_id=1234567-asdhfasdhbfkjlasdnfasf.apps.googleusercontent.com&redirect_uri=http%3A%2F%2Flocalhost%3A8085%2F&scope=openid+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fuserinfo.email+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fcloud-platform+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Fsqlservice.login+https%3A%2F%2Fwww.googleapis.com%2Fauth%2Faccounts.reauth&state=asdfasdfasdfasdfasdfsadfsdafsafasfasfa&access_type=offline&code_challenge=asdfasdfasfawefawfasdfasdf&code_challenge_method=S256


Credentials saved to file: [/Users/username/.config/gcloud/application_default_credentials.json]

These credentials will be used by any library that requests Application Default Credentials (ADC).

Quota project "gcp-project-123" was added to ADC which can be used by Google client libraries for billing and quota. Note that some services may still bill the project owning the resource.


Updates are available for some Google Cloud CLI components.  To install them,
please run:
  $ gcloud components update



To take a quick anonymous survey, run:
  $ gcloud survey

$ 
```



Once the authentication process is complete, the output of the commands will display the location where the credentials have been stored, which is [/Users/username/.config/gcloud/application_default_credentials.json]. This path must be provided to the credentials in the terraform module to allow terraform to access GCP.

<br />

```json
provider "google" {
    credentials = file("<replace/path/to/credentials/file.json>")
}
```



<br />

Example:

```json
provider "google" {
    credentials = file("/Users/username/.config/gcloud/application_default_credentials.json")
}
```



- credentials:  path to the contents of a service account key file in JSON format. You can alternatively use the GOOGLE_CREDENTIALS environment variable, or any of the following ordered by precedence.
  - GOOGLE_CREDENTIALS
  - GOOGLE_CLOUD_KEYFILE_JSON
  - GCLOUD_KEYFILE_JSON

<br />

## Replace terraform module inputs:

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



- bucket_names: Please provide a comma-separated list of names for the GCP buckets you wish to create. Ensure that the names follow the GCP naming convention outlined in the following link: [ https://cloud.google.com/storage/docs/buckets#:~:text=by%2Dstep%20guide.-,Bucket%20names,Spaces%20are%20not%20allowed.](https://cloud.google.com/storage/docs/buckets#:~:text=by%2Dstep%20guide.-,Bucket%20names,Spaces%20are%20not%20allowed.)
- bucket_location: The GCS location(<https://cloud.google.com/storage/docs/locations>)
- service_account-account_id: The account id that is used to generate the service account email address and a stable unique id. It is unique within a project, must be 6-30 characters long, and match the regular expression `[a-z]([-a-z0-9]*[a-z0-9])`to comply with RFC1035.
- project: The ID of the project in which the resource belongs

<br />

To list project ids that your account has access to

```sh
gcloud projects list
```



<br />

Example:

```sh
$ gcloud projects list
PROJECT_ID             NAME                  PROJECT_NUMBER
gcp-project-123        tcloud                1234567891012
lab-and-dev            lab-and-dev           2101987654321
$ 
```



Then replace for project with the project_id(value in the first column) that you want to create GCP Buckets in. 

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



<br />

## Terraform Plan

The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure. The plan command alone does not actually carry out the proposed changes. You can use this command to check whether the proposed changes match what you expected before you apply the changes or share your changes with your team for broader review. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/plan)

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
      + project     = "gcp-project-123"
      + unique_id   = (known after apply)
    }

  # module.bucket.google_storage_bucket.bucket[0] will be created
  + resource "google_storage_bucket" "bucket" {
      + force_destroy               = false
      + id                          = (known after apply)
      + location                    = "US-EAST1"
      + name                        = "fake-bucket-name-1"
      + project                     = "gcp-project-123"
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
      + project               = "gcp-project-123"
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



<br />

## Create Infrastructure

The terraform apply command performs a plan just like terraform plan does, but then actually carries out the planned changes to each resource using the relevant infrastructure provider's API. It asks for confirmation from the user before making any changes, enter yes to approve. After approval it will create infrastructure. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/apply)

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
      + project     = "gcp-project-123"
      + unique_id   = (known after apply)
    }

  # module.bucket.google_storage_bucket.bucket[0] will be created
  + resource "google_storage_bucket" "bucket" {
      + force_destroy               = false
      + id                          = (known after apply)
      + location                    = "US-EAST1"
      + name                        = "fake-bucket-name-1"
      + project                     = "gcp-project-123"
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
      + project               = "gcp-project-123"
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
module.bucket.google_service_account.service_account[0]: Creation complete after 1s [id=projects/gcp-project-123/serviceAccounts/tcloud-tf-dev-service@gcp-project-123.iam.gserviceaccount.com]
module.bucket.google_storage_hmac_key.key[0]: Creating...
module.bucket.google_storage_bucket_iam_binding.binding[0]: Creating...
module.bucket.google_storage_hmac_key.key[0]: Creation complete after 0s [id=projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID]
module.bucket.google_storage_bucket_iam_binding.binding[0]: Creation complete after 4s [id=b/fake-bucket-name-1/roles/storage.admin]

Apply complete! Resources: 4 added, 0 changed, 0 destroyed.

Outputs:

Access_Key = "projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID"
Secret_Key = <sensitive>
bucket_names = "fake-bucket-name-1"
$ 
```