# AWS Buckets Managed By Terraform
Terraform code that creates and maintains infrastructure for stores, using Amazon Simple Storage Service (Amazon S3) which is an object storage service provided by AWS in multiple geographical regions.

# Table of Contents
1. [Requirements](#requirements)
2. [Guides](#guides)
3. [State File](#state-file)
5. [Sensitive Data in State File](#densitive-data-in-ftate-file)
6. [Terraform Backends](#terraform-backends)
7. [Terraform Policy Permissions](#terraform-policy-permissions)

# Guides
1. [How to Create AWS CLI Profile](Configure_AWS_CLI_Profile.md)
2. [How to Deploy Infrastructure](Create_Infrastructure.md)
3. [How to Get Values from output](Get_Outputs.md)
4. [How to Update Infrastructure](Update_Infrastructure.md)
5. [How to Import Existing Infrastructure](Import_Infrastructure.md)
6. [How to Destroy Infrastructure](Destroy_Infrastructure.md)


# Requirements
* To get started you should first create an account with Amazon Web Services if you haven't got one already. [You can do it here.][signup]
* The [Terraform CLI][terraform-install] (1.2.0+) installed.
* The [AWS CLI][aws-cli-install] installed.
* [Terraform Basics][terraform-build-infrastructure]
* If you want to encrypt the aws secret key a guide on how to create gpg encryption can be found [here][gpg-guide] 
* Configure a AWS CLI and recommend using  named [configured profile][named-profiles]

[signup]:https://portal.aws.amazon.com/billing/signup/iam?#/account
[aws-cli-install]:https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
[terraform-install]:https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
[terraform-build-infrastructure]:https://developer.hashicorp.com/terraform/tutorials/aws-get-started/aws-build
[gpg-guide]:https://menendezjaume.com/post/gpg-encrypt-terraform-secrets/
[named-profiles]:https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html#cli-configure-files-methods
[state]:https://developer.hashicorp.com/terraform/language/state
[state-purpose]:https://developer.hashicorp.com/terraform/language/state/purpose
[sensitive-data]:https://developer.hashicorp.com/terraform/language/state/sensitive-data
[s3-backend]:https://developer.hashicorp.com/terraform/language/settings/backends/s3
[backend]:https://developer.hashicorp.com/terraform/language/settings/backends/configuration
# State File
When using Terraform it needs to keep track of the infrastructure it's creating. It does this by means of a [state][state] file. This file is just a simple JSON file (though its extension is .tfstate) that defines the infrastructure that has been created by Terraform and any proposed changes. By default, this file is stored on the local machine where terraform commands are run and should be checked into git or any other source code management system used. More of the purpose of the state file can be explained [here][state-purpose]

# Sensitive Data in State File
The state file can handle sensitive data, if creating iam_user with access and secret key this will be stored in plain text in the state file. So recommend keeping state file [secure][sensitive-data]. 

# Terraform Backends
But because this is just a simple file, it can actually be edited by anyone that has access to it and this might cause unwanted behaviors in the state of your infrastructure. Also, this is not ideal for collaboration as git conflicts may arise if multiple developers are modifying their own local copy of the file. Terraform introduce multiple online storage locations for this file called [backends][backend], and [AWS S3][s3-backend] can be used as a backend to safely store your state file

# Terraform Policy Permissions
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