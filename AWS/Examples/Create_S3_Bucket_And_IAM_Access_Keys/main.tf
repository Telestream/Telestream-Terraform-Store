provider "aws" {
  region  = "<replace_with_region_to_deploy_into>"
  profile = "<replace_with_profile_name>"
}
module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
  bucket_names = ["<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>"]
  iam_access = {
    assume_role     = false // flag if not provided will default to true and create iam role instead of access keys
    iam_policy_name = "<replace_with_unique_for_policy>"
    iam_user_name   = "<replace_with_unique_name_for_user>"
  }
}

output "bucket_names" {
  value       = module.bucket.id
  description = "list of the of names of the buckets created by terraform"
}
output "bucket_arns" {
  value       = module.bucket.arn
  description = "list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]."
}
output "iam_policy_arn" {
  value       = module.bucket.iam_policy_arn
  description = "The ARN assigned by AWS to this policy."
}
output "iam_user_arn" {
  value       = module.bucket.iam_user_arn
  description = "The ARN assigned by AWS for this user."
}
output "iam_access_key_id" {
  value       = module.bucket.iam_access_key_id
  description = "Access key ID."
}
output "iam_access_key_secret" {
  value       = module.bucket.iam_access_key_secret
  description = "Secret access key."
  sensitive   = true
}