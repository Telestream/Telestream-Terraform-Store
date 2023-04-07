# AZURE Bucket Creation using Terraform
Terraform code that creates and maintains infrastructure for stores, using Azure Blob Storage which is an object storage service provided by Azure in multiple geographical regions.

# Table of Contents
1. [Requirements](#requirements)
2. [Guides](#guides)
3. [State File](#state-file)
5. [Sensitive Data in State File](#densitive-data-in-ftate-file)
6. [Terraform Backends](#terraform-backends)

# Guides
1. [How to Deploy Infrastructure](Create_Infrastructure.md)
2. [How to Get Values from output](Get_Outputs.md)
3. [How to Update Infrastructure](Update_Infrastructure.md)
4. [How to Import Existing Infrastructure](Import_Infrastructure.md)
5. [How to Destroy Infrastructure](Destroy_Infrastructure.md)


# Requirements
* Adding Azure as store options requires you to have a storage account with Microsoft Azure. This is where your data is stored in the containers (equivalent of buckets in AWS S3). You can start with the [free account][signup] for now.
* The [Terraform CLI][terraform-install] (1.2.0+) installed.
* The [Azure CLI][azure-cli-install] installed.
* [Terraform Basics][terraform-build-infrastructure]
* [Login to azure cli][cli-getting-started]

[signup]:https://azure.microsoft.com/en-us/free/
[azure-cli-install]:https://learn.microsoft.com/en-us/cli/azure/install-azure-cli
[terraform-install]:https://developer.hashicorp.com/terraform/tutorials/azure-get-started/install-cli
[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/azure-get-started/azure-build
[cli-getting-started]:https://learn.microsoft.com/en-us/cli/azure/get-started-with-azure-cli
[state]:https://developer.hashicorp.com/terraform/language/state
[state-purpose]:https://developer.hashicorp.com/terraform/language/state/purpose
[sensitive-data]:https://developer.hashicorp.com/terraform/language/state/sensitive-data
[azure-backend]:https://developer.hashicorp.com/terraform/language/settings/backends/azurerm
[backend]:https://developer.hashicorp.com/terraform/language/settings/backends/configuration
# State File
When using Terraform it needs to keep track of the infrastructure it's creating. It does this by means of a [state][state] file. This file is just a simple JSON file (though its extension is .tfstate) that defines the infrastructure that has been created by Terraform and any proposed changes. By default, this file is stored on the local machine where terraform commands are run and should be checked into git or any other source code management system used. More of the purpose of the state file can be explained [here][state-purpose]

# Sensitive Data in State File
The state file can handle sensitive data, if creating storage_account with access key and connection string this will be stored in plain text in the state file. So recommend keeping state file [secure][sensitive-data]. 

# Terraform Backends
But because this is just a simple file, it can actually be edited by anyone that has access to it and this might cause unwanted behaviors in the state of your infrastructure. Also, this is not ideal for collaboration as git conflicts may arise if multiple developers are modifying their own local copy of the file. Terraform introduce multiple online storage locations for this file called [backends][backend], and [AZURE][azure-backend] can be used as a backend to safely store your state file

