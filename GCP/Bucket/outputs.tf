// bucket
output "bucket_self_link" {
    value         =  join(",", google_storage_bucket.bucket.*.self_link) 
    description   = " The URI of the created resource."  
}
output "bucket_url" {
    value         = join(",", google_storage_bucket.bucket.*.url) 
    description   = "The base URL of the bucket, in the format gs://<bucket-name>."  
}
output "bucket_name" {
    value         = join(",", google_storage_bucket.bucket.*.name) 
    description   = "The name of the bucket"  
}
//google_service_account
output "service_account_id" {
    value         = join("", google_service_account.service_account.*.id) 
    description   = "an identifier for the resource with format projects/{{project}}/serviceAccounts/{{email}}"
}
output "service_account_email" {
    value         = join("", google_service_account.service_account.*.email) 
    description   = "The e-mail address of the service account. This value should be referenced from any google_iam_policy data sources that would grant the service account privileges."
}
output "service_account_name" {
    value         = join("", google_service_account.service_account.*.name)
    description   = "The fully-qualified name of the service account."
}
output "service_account_unique_id" {
    value         = join("", google_service_account.service_account.*.unique_id) 
    description   = "The unique id of the service account."
}
output "service_account_member" {
    value         = join("", google_service_account.service_account.*.member)
    description   = "The Identity of the service account in the form serviceAccount:{email}. This value is often used to refer to the service account in order to grant IAM permissions."
}
//google_storage_bucket_access_control
output "google_storage_bucket_iam_etag" {
    value         =  join(",", google_storage_bucket_iam_binding.binding.*.etag )
    description   = "The etag of the IAM policy."
}
//google_storage_hmac_key
output "key_access_id" {
  value         =  join("", google_storage_hmac_key.key.*.access_id)
  description   = "The access ID of the HMAC Key."
}
output "key_time_created" {
  value         =  join("", google_storage_hmac_key.key.*.time_created)
  description   = "The creation time of the HMAC key in RFC 3339 format. "
}
output "key_updated" {
  value         =  join("", google_storage_hmac_key.key.*.updated)
  description   = "The last modification time of the HMAC key metadata in RFC 3339 format."
}
output "key_id" {
  value       =  join("", google_storage_hmac_key.key.*.id)
  description = "an identifier for the resource with format projects/{{project}}/hmacKeys/{{access_id}}"
}

output "key_secret" {
  value         = google_storage_hmac_key.key.*.secret == null ? null : join("", google_storage_hmac_key.key.*.secret)
  description   = "HMAC secret key material. Note: This property is sensitive and will not be displayed in the plan."
  sensitive     = true
}


