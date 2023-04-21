provider "aws" {
  region  = "<replace_with_region_to_deploy_into>"
  profile = "<replace_with_profile_name>"
}

module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
  bucket_names = ["<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>"]
  iam_access = {
    iam_policy_name = "<replace_with_unique_name_for_policy>"
    iam_role_name   = "<replace_with_unique_name_for_role>"
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
output "iam_role_arn" {
  value       = module.bucket.iam_role_arn
  description = "Amazon Resource Name (ARN) specifying the role."
}