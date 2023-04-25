
# How to configure AWS CLI Profile

# Table of Contents
1. [Requirements](README.md)
2. [How to create AWS Profile](#create-aws-profile)
3. [IAM Permissions Required to be attached to IAM User](#iam-permissions-required-to-be-attached-to-iam-user)
4. [Verify that profile was created correctly](#verify-that-profile-was-created-correctly)

# Create AWS Profile

AWS Documentation on configuring AWS CLI can be found [here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods).  Bellow is the command to create a named profile for AWS CLI access required by terraform to works.

Command:

```Text shell
aws configure --profile <yourProfileName>
```



```sh
$ aws configure --profile <yourProfileName>
AWS Access Key ID [None]: enter your iam user acccess key id 
AWS Secret Access Key [None]: enter your iam secret user acccess key 
Default region name [None]: enter default region(optional can just hit enter and skip)
Default output format [None]: enter default output format(optional can just hit enter and skip)
```



In the above:

- Recommend for profile name to reference the environment that access/secret key has access to. Example could be tcloud-store-sandbox, tcloud-store-dev, tcloud-store-staging or tcloud-store-prod.
- [None] – This indicates that you don’t have any existing access-key-id/secret-access-key setup on your system for this named profile, and will prompt you for new values.
- Region Name – This is optional. And can be left blank by hitting enter.
- Output – This is optional. If you leave this empty by hitting enter, the output of all AWS CLI will be in json format. Available output options are: json, text, table
- Use the access/secret key that was created in Previous Page Create AWS IAM User, or from a IAM User that has the correct permissions Terraform requires to deploy infrastructure

# IAM Permissions Required to be attached to IAM User

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "iam:GetPolicyVersion",
                "iam:DeleteAccessKey",
                "iam:CreateRole",
                "s3:CreateBucket",
                "iam:AttachRolePolicy",
                "s3:GetBucketObjectLockConfiguration",
                "iam:DetachRolePolicy",
                "iam:ListAttachedRolePolicies",
                "s3:PutBucketAcl",
                "iam:ListRolePolicies",
                "iam:DetachUserPolicy",
                "iam:GetRole",
                "iam:GetPolicy",
                "s3:GetBucketWebsite",
                "iam:UpdateUser",
                "iam:AttachUserPolicy",
                "iam:DeleteRole",
                "iam:UpdateAccessKey",
                "iam:TagPolicy",
                "s3:GetReplicationConfiguration",
                "iam:ListGroupsForUser",
                "s3:GetLifecycleConfiguration",
                "s3:GetBucketTagging",
                "iam:UntagRole",
                "iam:TagRole",
                "s3:GetBucketLogging",
                "iam:DeletePolicy",
                "s3:ListBucket",
                "s3:GetAccelerateConfiguration",
                "iam:CreateUser",
                "s3:GetBucketPolicy",
                "iam:CreateAccessKey",
                "iam:ListInstanceProfilesForRole",
                "s3:GetEncryptionConfiguration",
                "s3:PutBucketTagging",
                "s3:GetBucketRequestPayment",
                "iam:ListAttachedUserPolicies",
                "s3:GetBucketOwnershipControls",
                "s3:DeleteBucket",
                "s3:PutObjectAcl",
                "iam:ListAccessKeys",
                "s3:GetBucketPublicAccessBlock",
                "s3:PutBucketPublicAccessBlock",
                "s3:PutBucketOwnershipControls",
                "iam:DeleteUser",
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "iam:TagUser",
                "iam:CreatePolicy",
                "iam:UntagUser",
                "iam:ListPolicyVersions",
                "s3:ListAllMyBuckets",
                "s3:GetBucketCORS",
                "iam:UntagPolicy",
                "iam:UpdateRole",
                "iam:GetUser"
            ],
            "Resource": "*"
        }
    ]
}
```



Example:

```sh
$ aws configure --profile tcloud-store-prod
AWS Access Key ID [None]: AKIAI44QH8DHBEXAMPLE
AWS Secret Access Key [None]: je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
Default region name [None]: 
Default output format [None]: 
```



### Remember the profile name created, because it will be used in terraform modules

# Verify that profile was created correctly

To verify you can run AWS CLI command using the profile you created. It should list all S3 buckets from the AWS account the IAM user was created in.

```sh
$ aws s3 ls --profile tcloud-store-prod
2022-06-08 01:42:44 fake-bucket-name-us-east-1
2022-06-08 01:33:46 fake-bucket-name-us-east-2
2023-04-21 14:45:07 test-bucket-dev-eu-west-1
$ 
```