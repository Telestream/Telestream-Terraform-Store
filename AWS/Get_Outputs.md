# How to Get Values from Output AWS
Goes over how to extract values from terraform state file [outputs][terraform-output]

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
$ terraform output -json
{
  "bucket_arns": {
    "sensitive": false,
    "type": "string",
    "value": "arn:aws:s3:::fake-bucket-name"
  },
  "bucket_names": {
    "sensitive": false,
    "type": "string",
    "value": "fake-bucket-name"
  },
  "iam_access_key_id": {
    "sensitive": false,
    "type": "string",
    "value": "AKIAI44QH8DHBEXAMPLE"
  },
  "iam_access_key_secret": {
    "sensitive": true,
    "type": [
      "tuple",
      [
        "string"
      ]
    ],
    "value": [
      "je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY"
    ]
  },
  "iam_policy_arn": {
    "sensitive": false,
    "type": "string",
    "value": "arn:aws:iam::012345678901:policy/tcloud_store_access_policy20230325172359608400000001"
  },
  "iam_user_arn": {
    "sensitive": false,
    "type": "string",
    "value": "arn:aws:iam::012345678901:user/tcloud_store_access_user"
  }
}
$ 
```
* **bucket_names** value is a list of the bucket names created
* **iam_access_key_id** value is the access key needed by telestream store if using Access Key and Secret Key Authorization Method
* **iam_access_key_secret** value is the secret key needed by telestream store if using Access Key and Secret Key Authorization Method 
* **iam_role_arn** value is the AWS IAM Role needed by telestream store if using AWS IAM Role Authorization Method
* **iam_policy_arn** The ARN assigned by AWS to this policy

