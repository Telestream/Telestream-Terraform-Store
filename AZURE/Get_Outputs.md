# How to Get Values from output AZURE
Goes over how to extract values from terraform state file
# Table of Contents
1. [Requirements](README.md)
2. [Get terraform outputs](#get-terraform-outputs)

## Get terraform outputs

The terraform output command is used to extract the value of an output variable from the state file. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/output)

<br />

Go into the directory with the `main.tf` and `terraform.tfstate` to run the terraform output command. Add -json parameter for a more readable output.

```sh
terraform output -json
```



Example

```sh
$ terraform output -json
{
  "bucket_names": {
    "sensitive": false,
    "type": "string",
    "value": "fake-bucket-name-1,fake-bucket-name-2,fake-bucket-name-3"
  },
  "storage_account_name": {
    "sensitive": false,
    "type": "string",
    "value": "tcaccount"
  },
  "storage_account_primary_access_key": {
    "sensitive": true,
    "type": "string",
    "value": "randomcharactersHEREWillBeYourPrimary-Acces-Key"
  },
  "storage_account_primary_connection_string": {
    "sensitive": true,
    "type": "string",
    "value": "DefaultEndpointsProtocol=https;AccountName=tcaccount;AccountKey=randomcharactersHEREWillBeYourPrimary-Acces-Key;EndpointSuffix=core.windows.net"
  },
  "storage_account_secondary_access_key": {
    "sensitive": true,
    "type": "string",
    "value": "randomcharactersHEREWillBeYourSecondary-Acces-Key"
  },
  "storage_account_secondary_connection_string": {
    "sensitive": true,
    "type": "string",
    "value": "DefaultEndpointsProtocol=https;AccountName=tcaccount;AccountKey=randomcharactersHEREWillBeYourSecondary-Acces-Key;EndpointSuffix=core.windows.net"
  }
}
$
```



- **bucket_names** The name of the Container which created within the Storage Account
- **storage_account_name** Specifies the name of the storage account.
- **storage_account_primary_access_key** The primary access key for the storage account.
- **storage_account_primary_connection_string** The connection string associated with the primary location.
- **storage_account_secondary_access_key** The secondary access key for the storage account.
- **storage_account_secondary_connection_string** The connection string associated with the secondary location.