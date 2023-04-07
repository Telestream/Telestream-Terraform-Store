# How to Get Values from output
Goes over how to extract values from terraform state file

# Table of Contents
1. [Requirements](README.md)
2. [Get terraform outputs](#get-terraform-outputs)

[terraform-output]:https://developer.hashicorp.com/terraform/cli/commands/output

# Get terraform outputs
The terraform output command is used to extract the value of an output variable from the state file. Terraform documentation can be found [here][terraform-output]
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
    "value": "projects/cloud-engineering-123/hmacKeys/GOOG1EC62JWZUXHHAQ3GRARQS4G2E3DASPOBYFAKEACCESSKEYID"
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
* **Access_Key** an identifier for the resource with format projects/{{project}}/hmacKeys/{{access_id}}
* **Secret_Key** HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan.
* **bucket_names** The name of the bucket


