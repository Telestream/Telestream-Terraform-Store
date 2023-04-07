provider "google" {
    credentials = file("<replace/path/to/credentials/file.json>")
}
//minium needed to create bucket
module "bucket" {
    source          = "github.com/Telestream/Telestream-Terraform-Store/GCP/Bucket"
    bucket_names    = ["<replace_with_unique_name_of_bucket>"]
    bucket_location = "<replace_with_location_of_bucket>"
    project         = "<replace_with_project_id_deploying_into>"
    service_account = {
        account_id                  = "<replace_with_service_account_id_name>"
        create_service_account_key  = false
    }
}
output "bucket_names" {
  value       = module.bucket.bucket_name
  description = "The name of the bucket"  
}
