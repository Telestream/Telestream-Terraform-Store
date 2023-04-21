provider "aws" {
  region  = "<replace_with_region_to_deploy_into>"
  profile = "<replace_with_profile_name>"
}
/*
Will create as many buckets as in list, and each bucket will have its own role and policy, with a unique name with the same prefix
*/
variable "bucket_names" {
  default = ["<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>", "<replace_with_unique_name_of_bucket>"]
  type    = list(string)
}
module "bucket" {
  count        = length(var.bucket_names)
  source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
  bucket_names = [var.bucket_names[count.index]]
  iam_access = {
    iam_policy_name_prefix = "<replace_with_unique_prefix_for_policy>"
    iam_role_name_prefix   = "<replace_with_unique_prefix_for_role>"
  }
}
output "bucket_names" {
  value       = module.bucket.*.id
  description = "list of the of names of the buckets created by terraform"
}
output "bucket_arns" {
  value       = module.bucket.*.arn
  description = "list of the ARNs of the buckets. Will be of format [arn:aws:s3:::bucketname]."
}
output "iam_policy_arn" {
  value       = module.bucket.*.iam_policy_arn
  description = "The ARN assigned by AWS to this policy."
}
output "iam_role_arn" {
  value       = module.bucket.*.iam_role_arn
  description = "Amazon Resource Name (ARN) specifying the role."
}
output "iam_role_arn_bucket_map" {
  value = tomap({
    for i, id in module.bucket.*.id :
    id => module.bucket.*.iam_role_arn[i]
  })
  description = "Maping the bucket to the iam role that has access to the bucket"
}