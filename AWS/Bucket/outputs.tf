// bucket
output "id" {
  value       = join(",", aws_s3_bucket.bucket.*.id)
  description = "The name of the bucket."
}
output "acceleration_status" {
  value       = join(",", aws_s3_bucket.bucket.*.acceleration_status)
  description = "(Optional) The accelerate configuration status of the bucket. Not available in cn-north-1 or us-gov-west-1."
}
output "acl" {
  value       = aws_s3_bucket.bucket.*.acl
  description = "The canned ACL applied to the bucket."
}
output "arn" {
  value       = join(",", aws_s3_bucket.bucket.*.arn)
  description = "The ARN of the bucket. Will be of format arn:aws:s3:::bucketname."
}
output "bucket_domain_name" {
  value       = join(",", aws_s3_bucket.bucket.*.bucket_domain_name)
  description = "The bucket domain name. Will be of format bucketname.s3.amazonaws.com."
}
output "bucket_regional_domain_name" {
  value       = join(",", aws_s3_bucket.bucket.*.bucket_regional_domain_name)
  description = "The bucket region-specific domain name. The bucket domain name including the region name, please refer here for format. Note: The AWS CloudFront allows specifying S3 region-specific endpoint when creating S3 origin, it will prevent redirect issues from CloudFront to S3 Origin URL."
}
output "cors_rule" {
  value       = aws_s3_bucket.bucket.*.cors_rule
  description = "Set of origins and methods (cross-origin access allowed)."
}
output "grant" {
  value       = aws_s3_bucket.bucket.*.grant
  description = "The set of ACL policy grants."
}
output "hosted_zone_id" {
  value       = join(",", aws_s3_bucket.bucket.*.hosted_zone_id)
  description = "The Route 53 Hosted Zone ID for this bucket's region."
}
output "lifecycle_rule" {
  value       = aws_s3_bucket.bucket.*.lifecycle_rule
  description = "A configuration of object lifecycle management."
}
output "logging" {
  value       = aws_s3_bucket.bucket.*.logging
  description = "The logging parameters for the bucket."
}
output "object_lock_configuration" {
  value       = aws_s3_bucket.bucket.*.object_lock_configuration
  description = "The S3 object locking configuration."
}
output "policy" {
  value       = join(",", aws_s3_bucket.bucket.*.policy)
  description = "The bucket policy JSON document."
}
output "region" {
  value       = join(",", aws_s3_bucket.bucket.*.region)
  description = "The AWS region this bucket resides in."
}
output "replication_configuration" {
  value       = aws_s3_bucket.bucket.*.replication_configuration
  description = "The replication configuration."
}
output "request_payer" {
  value       = join(",", aws_s3_bucket.bucket.*.request_payer)
  description = "Either BucketOwner or Requester that pays for the download and request fees."
}
output "server_side_encryption_configuration" {
  value       = aws_s3_bucket.bucket.*.server_side_encryption_configuration
  description = "The server-side encryption configuration."
}
output "tags_all" {
  value       = aws_s3_bucket.bucket.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}
output "versioning" {
  value       = aws_s3_bucket.bucket.*.versioning
  description = "The versioning state of the bucket."
}

// iam policy
output "iam_policy_id" {
  value       = join("", aws_iam_policy.policy.*.id)
  description = "The ARN assigned by AWS to this policy."
}
output "iam_policy_arn" {
  value       = var.iam_access.create_iam ? join("", aws_iam_policy.policy.*.arn) : null
  description = "The ARN assigned by AWS to this policy."
}
output "iam_policy_description" {
  value       = join("", aws_iam_policy.policy.*.description)
  description = "The description of the policy."
}
output "iam_policy_name" {
  value       = join("", aws_iam_policy.policy.*.name)
  description = "The name of the policy."
}
output "iam_policy_path" {
  value       = join("", aws_iam_policy.policy.*.path)
  description = "The path of the policy in IAM."
}
output "iam_policy_policy" {
  value       = join("", aws_iam_policy.policy.*.policy)
  description = "The policy document."
}
output "iam_policy_policy_id" {
  value       = join("", aws_iam_policy.policy.*.policy_id)
  description = "The policy's ID."
}
output "iam_policy_tags_all" {
  value       = aws_iam_policy.policy.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}

// iam role
output "iam_role_arn" {
  value       = local.create_iam_role ? join("", aws_iam_role.role.*.arn) : null
  description = "Amazon Resource Name (ARN) specifying the role."
}
output "iam_role_create_date" {
  value       = join("", aws_iam_role.role.*.create_date)
  description = "Creation date of the IAM role."
}
output "iam_role_id" {
  value       = join("", aws_iam_role.role.*.id)
  description = "Name of the role."
}
output "iam_role_name" {
  value       = join("", aws_iam_role.role.*.name)
  description = "Name of the role."
}
output "iam_role_unique_id" {
  value       = join("", aws_iam_role.role.*.unique_id)
  description = "Stable and unique string identifying the role."
}
output "iam_role_tags_all" {
  value       = aws_iam_role.role.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}
// iam user
output "iam_user_arn" {
  value       = local.create_iam_user ? join("", aws_iam_user.user.*.arn) : null
  description = "The ARN assigned by AWS for this user."
}
output "iam_user_name" {
  value       = join("", aws_iam_user.user.*.name)
  description = "The user's name."
}
output "iam_user_unique_id" {
  value       = join("", aws_iam_user.user.*.unique_id)
  description = "The unique ID assigned by AWS."
}
output "iam_user_tags_all" {
  value       = aws_iam_user.user.*.tags_all
  description = "A map of tags assigned to the resource, including those inherited from the provider default_tags configuration block."
}
output "iam_access_key_secret" {
  value       = aws_iam_access_key.iam_access_key.*.secret
  sensitive   = true
  description = "Secret access key. This attribute is not available for imported resources. Note that this will be written to the state file. If you use this, please protect your backend state file judiciously. Alternatively, you may supply a pgp_key instead, which will prevent the secret from being stored in plaintext, at the cost of preventing the use of the secret key in automation."
}
output "iam_access_key_create_date" {
  value       = join("", aws_iam_access_key.iam_access_key.*.create_date)
  description = "Date and time in RFC3339 format that the access key was created."
}
output "iam_access_key_encrypted_secret" {
  value       = local.create_iam_user ? try(aws_iam_access_key.iam_access_key[0].encrypted_secret, "") : null
  description = "Encrypted secret, base64 encoded, if pgp_key was specified. This attribute is not available for imported resources. The encrypted secret may be decrypted using the command line, for example: terraform output -raw encrypted_secret | base64 --decode | keybase pgp decrypt."
}
output "iam_access_key_encrypted_secret_key_decrypt_command" {
  description = "Decrypt access secret key command"
  value       = !local.create_iam_user || var.iam_access.iam_user_pgp_key == null ? null : <<EOF
  echo "${try(aws_iam_access_key.iam_access_key[0].encrypted_secret, "")}" | base64 --decode | gpg --decrypt
  EOF 
}
output "iam_access_key_encrypted_ses_smtp_password_v4" {
  value       = aws_iam_access_key.iam_access_key.*.encrypted_ses_smtp_password_v4
  description = "Encrypted SES SMTP password, base64 encoded, if pgp_key was specified. This attribute is not available for imported resources. The encrypted password may be decrypted using the command line, for example: terraform output -raw encrypted_ses_smtp_password_v4 | base64 --decode | keybase pgp decrypt."
}
output "iam_access_key_id" {
  value       = local.create_iam_user ? join("", aws_iam_access_key.iam_access_key.*.id) : null
  description = "Access key ID."
}
output "iam_access_key_key_fingerprint" {
  value       = aws_iam_access_key.iam_access_key.*.key_fingerprint
  description = "Fingerprint of the PGP key used to encrypt the secret. This attribute is not available for imported resources."
}
output "iam_access_key_pgp_key" {
  value       = var.iam_access.iam_user_pgp_key
  description = "Either a base-64 encoded PGP public key, or a keybase username in the form keybase:some_person_that_exists, used to encrypt iam in the encrypted_secret output attribute. If providing a base-64 encoded PGP public key, make sure to provide the raw version and not the armored one (e.g. avoid passing the -a option to gpg --export)"
}

