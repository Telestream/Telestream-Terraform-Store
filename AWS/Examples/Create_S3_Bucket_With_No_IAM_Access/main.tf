provider "aws" {
  region  = "<replace_with_region_to_deploy_into>"
  profile = "<replace_with_profile_name>"
}
// Will only create an s3 bucket since create_iam is set to false
module "bucket" {
  source       = "github.com/Telestream/Telestream-Terraform-Store/AWS/Bucket"
  bucket_names = ["<replace_with_unique_name_of_bucket>"]
  iam_access = {
    create_iam = false // if false will not create any iam resources
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