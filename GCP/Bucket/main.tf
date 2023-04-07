locals {
  create_service_account      = var.enabled && var.service_account.create_service_account && length(var.bucket_names) > 0
  create_service_account_key  = local.create_service_account && var.service_account.create_service_account_key
}
// create google bucket
resource "google_storage_bucket" "bucket" {
  count                       = var.enabled ? length(var.bucket_names) : 0
  name                        = var.bucket_names[count.index]
  location                    = var.bucket_location
  storage_class               = var.storage_class
  force_destroy               = var.force_destroy
  project                     = var.project 
  uniform_bucket_level_access = var.uniform_bucket_level_access 
  public_access_prevention    = var.public_access_prevention 
}
// create service acccount
resource "google_service_account" "service_account" {
  count         = local.create_service_account ? 1 : 0
  account_id    = var.service_account.account_id 
  display_name  = var.service_account.display_name
  description   = var.service_account.description
  disabled      = var.service_account.disabled
  project       = var.project 
}
// assign service account to bucket
resource "google_storage_bucket_iam_binding" "binding" {
  count   = local.create_service_account ? length(var.bucket_names) : 0
  bucket  = element(google_storage_bucket.bucket.*.name, count.index)
  role    = "roles/storage.admin"
  members = [
    "serviceAccount:${join("", google_service_account.service_account.*.email)}",
  ]
}

// create the HMAC key for the associated service account 
resource "google_storage_hmac_key" "key" {
  count                 = local.create_service_account_key ? 1 : 0
  service_account_email = join("", google_service_account.service_account.*.email)
  state                 = var.service_account.key_state
  project               = var.project
}



