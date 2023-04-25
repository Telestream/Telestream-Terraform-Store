# How to Get Values from Output AWS
The terraform output command is used to extract the value of an output variable from the state file. Terraform documentation can be found [here](https://developer.hashicorp.com/terraform/cli/commands/output)
<br />


# Table of Contents
1. [Requirements](README.md)
2. [Get terraform outputs](#get-terraform-outputs)

[terraform-output]:https://developer.hashicorp.com/terraform/cli/commands/output

# Get terraform outputs
Go into the directory with the `main.tf` and `terraform.tfstate` to run the terraform output command. Add -json parameter for a more readable output.

```shell shell
terraform output -json
```


Example

```shell
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



- **bucket_names**: The value is a list of the bucket names created
- **iam_access_key_id**: The value is the access key needed by Telestream store if using Access Key and Secret Key Authorization Method
- **iam_access_key_secret**: The balue is the secret key needed by Telestream store if using Access Key and Secret Key Authorization Method 
- **iam_role_arn**: The balue is the AWS IAM Role needed by Telestream store if using AWS IAM Role Authorization Method
- **iam_policy_arn**: The ARN assigned by AWS to this policy
- **iam_user_arn**: The ARN assigned by AWS for this user.