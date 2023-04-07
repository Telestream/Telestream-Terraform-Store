provider "aws" {
  region  = "<replace_with_region_to_deploy_into>"
  profile = "<replace_with_profile_name>"
}
/*
Will create as many buckets as in list, and all buckets will share the same role and policy
*/
module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
  bucket_names = ["<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>"]
  iam_access = {
    //will create policy and role with provided prefix and append random string afterwards to ensure name is unique
    iam_policy_name_prefix = "<replace_with_unique_prefix_for_policy>"
    iam_role_name_prefix   = "<replace_with_unique_prefix_for_role>"
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