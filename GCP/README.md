# GCP Bucket Creation using Terraform
Terraform code that creates and maintains infrastructure for stores, using  Google Cloud Storage which is an object storage service provided by Google Cloud Platform (GCP) in multiple geographical regions.

# Table of Contents
1. [Requirements](#requirements)
2. [Guides](#guides)
3. [State File](#state-file)
5. [Sensitive Data in State File](#sensitive-data-in-state-file)
6. [Terraform Backends](#terraform-backends-keep-state-file-secure)


# Guides
1. [How to Deploy Infrastructure](Create_Infrastructure.md)
2. [How to Get Values from output](Get_Outputs.md)
3. [How to Update Infrastructure](Update_Infrastructure.md)
4. [How to Import Existing Infrastructure](Import_Infrastructure.md)
5. [How to Destroy Infrastructure](Destroy_Infrastructure.md)


# Requirements
- The [Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/install-cli) (1.2.0+) installed.
- The [GCloud CLI](https://cloud.google.com/sdk/docs/install) installed.
- [Terraform Basics](https://developer.hashicorp.com/terraform/tutorials/gcp-get-started/google-cloud-platform-build)
* If you have an account with Google Cloud, log-in to your account and either create a project for Telestream Cloud (go to https://console.cloud.google.com/projectcreate) or pick one of your existing projects.
![alt text](images/gcp_project.png)



## State File

When using Terraform it needs to keep track of the infrastructure it's creating. It does this by means of a [state](https://developer.hashicorp.com/terraform/language/state)file. This file is just a simple JSON file (though its extension is terraform.tfstate) that defines the infrastructure that has been created by Terraform and any proposed changes. By default, this file is stored on the local machine where terraform commands are run and should be checked into git or any other source code management system used. More of the purpose of the state file can be explained [here](https://developer.hashicorp.com/terraform/language/state/purpose). Terraform compares your configuration with the state file and your existing infrastructure to create plans and make changes to your infrastructure. When you run terraform apply or terraform destroy against your initialized configuration, Terraform writes metadata about your configuration to the state file and updates your infrastructure resources accordingly.

<br />

## Sensitive Data in State File

The state file can handle sensitive data, if creating storage_account with access key and connection string this will be stored in plain text in the state file. So recommend keeping state file [secure](https://developer.hashicorp.com/terraform/language/state/sensitive-data).

<br />

# IMPORTANT TO KEEP STATE FILE SAFE

## Terraform Backends Keep State File Secure

If the state file is deleted terraform will lose track of the infrastructure it has created, so it is important to keep state file in safe place where it wont be deleted, like Terraform [backends](https://developer.hashicorp.com/terraform/language/settings/backends/configuration). Also since it is just a simple file, it can actually be edited by anyone that has access to it and this might cause unwanted behaviors in the state of your infrastructure. This is not ideal for collaboration as git conflicts may arise if multiple developers are modifying their own local copy of the file. Terraform introduce multiple online storage locations for this file called called [backends](https://developer.hashicorp.com/terraform/language/settings/backends/configuration), and [GCP](https://developer.hashicorp.com/terraform/language/settings/backends/gcs) can be used as a backend to safely store your state file.