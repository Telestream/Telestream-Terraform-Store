# How to Get Values from output GCP
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
terraform output -json
{
  "Access_Key": {
    "sensitive": false,
    "type": "string",
    "value": "projects/gcp-project-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID"
  },
  "Secret_Key": {
    "sensitive": true,
    "type": "string",
    "value": "7BIaBemdMkG/8zxLMcU+mgYFAKESECRETKEYID"
  },
  "bucket_names": {
    "sensitive": false,
    "type": "string",
    "value": "fake-bucket-name-1"
  }
}
$
```



- **Access_Key** an identifier for the resource with format projects/{{project}}/hmacKeys/{{access_id}}
- **Secret_Key** HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan.
- **bucket_names** The list of names for the buckets created