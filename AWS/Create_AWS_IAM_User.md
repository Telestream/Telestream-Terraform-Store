# Create AWS IAM User
These are the steps on how to create a AWS IAM User, Access/Secret key, and provide the IAM User with required permissions to allow terraform to use to deploy infrastructure. If you already have a IAM User, you can skip bellow steps, but make sure the user has the IAM [permissions](#permissions) terraform requires to deploy infrastructure listed bellow. 

# Table of Contents
1. [Requirements](README.md)
2. [Create IAM Access Key and Secret Key pair](#create-iam-access-key-and-secret-key-pair)
3. [IAM Permissions](#permissions)
4. [To create, modify, or delete your own IAM user access keys](#to-create-modify-or-delete-your-own-iam-user-access-keys)
5. [To create, modify, or delete another IAM user's access keys](#to-create-modify-or-delete-another-iam-users-access-keys)
# Create IAM Access Key and Secret Key pair

AWS Access Key and Secret Key pairs can be used instead of IAM roles for setting up STORES.  
This can be accomplished by accessing the "Identity and Access Management (IAM)" page within the AWS console. There are 2 methods to creating a new Access Key/Secret Key pair.

1. When new adding a new user.
2. Manually creating a new Access Key/Secret Key for an existing user.

<br />
## To create an IAM user (console)

1. Sign in to the AWS Management Console and open the IAM console at <https://console.aws.amazon.com/iam/>
2. In the navigation pane, choose _Users_ and then choose _Add users._
3. Type the user name for the new user. This is the sign-in name for AWS.
4. Select the type of access this set of users will have. You can select programmatic access, access to the AWS Management Console, or both.

- Select _Programmatic access_ if the users require access to the API, AWS CLI, or Tools for Windows PowerShell. This creates an access key for each new user. You can view or download the access keys when you get to the Final page.

- Select_ AWS Management Console_ access if the users require access to the AWS Management Console. This creates a password for each new user.

- For _Console password_, choose one of the following:

  - Autogenerated password. Each user gets a randomly generated password that meets the account password policy. You can view or download the passwords when you get to the Final page.
  - Custom password. Each user is assigned the password that you type in the box.

5. Choose _Next: Permissions._
6. On the _Set permissions_ page, specify how you want to assign permissions to this set of new users. Choose one of the following three options:

- _Add user to group._ Choose this option if you want to assign the users to one or more groups that already have permissions policies. IAM displays a list of the groups in your account, along with their attached policies. You can select one or more existing groups, or choose Create group to create a new group. For more information, see Changing permissions for an IAM user.
- Policy permissions required

# Permissions

When terraform interacts with your AWS account to create infrastructure, it will use IAM permissions attached to the IAM User. Listed bellow are all IAM permissions required for terraform to properly create infrastructure. Without this you will see IAM permission denied errors when deploying terraform.

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



7. Choose _Next: Tags._
8. Choose _Next: Review_ to see all of the choices you made up to this point. When you are ready to proceed, choose _Create user._
9. To view the users' access keys (access key IDs and secret access keys), choose _Show_ next to each password and access key that you want to see. To save the access keys, choose _Download_ .csv and then save the file to a safe location.

### NOTE: Only the user's access key ID is visible. The secret access key can only be retrieved when the key is created.

<br />

# To create, modify, or delete your own IAM user access keys

1. Use your AWS account ID or account alias, your IAM user name, and your password to sign in to the IAM console.
2. In the navigation bar on the upper right, choose your user name and then choose My Security Credentials.
3. Expand the Access keys (access key ID and secret access key) section.
4. Do any of the following:

- To create an access key, choose Create New Access Key. If this feature is disabled, then you must delete one of the existing keys before you can create a new one. A warning explains that you have only this one opportunity to view or download the secret access key. To copy the key to paste it somewhere else for safekeeping, choose Show Access Key. To save the access key ID and secret access key to a .csv file to a secure location on your computer, choose Download Key File.
- To disable an active access key, choose Make Inactive.
- To reenable an inactive access key, choose Make Active.
- To delete your access key, choose Delete. AWS recommends that before you do this, you first deactivate the key and test that it’s no longer in use. When you use the AWS Management Console, you must deactivate your key before deleting it.

### Note: Only the user's access key ID is visible. The secret access key can only be retrieved when the key is created.

<br />

# To create, modify, or delete another IAM user's access keys

1. Sign in to the AWS Management Console and open the IAM console at <https://console.aws.amazon.com/iam/>.
2. In the navigation pane, choose Users.
3. Choose the name of the user whose access keys you want to manage, and then choose the Security credentials tab.
4. In the Access keys section, do any of the following:

- To create an access key, choose Create access key. Then choose Download .csv file to save the access key ID and secret access key to a CSV file on your computer. Store the file in a secure location. You will not have access to the secret access key again after this dialog box closes. After you download the CSV file, choose Close. When you create an access key, the key pair is active by default, and you can use the pair right away.
- To disable an active access key, choose Make inactive.
- To reenable an inactive access key, choose Make active.
- To delete your access key, choose Delete. AWS recommends that before you do this, you first deactivate the key and test that it’s no longer in use. When you use the AWS Management Console, you must deactivate your key before deleting it.

### Note: Only the user's access key ID is visible. The secret access key can only be retrieved when the key is created.

<br />