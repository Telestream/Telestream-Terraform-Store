locals {
  // if using assume role will use BucketOwnerEnforced if access keys need BucketOwnerPreferred
  s3_object_ownership = try(var.iam_access.assume_role ? "BucketOwnerEnforced" : "BucketOwnerPreferred", "BucketOwnerEnforced")
  create_iam_role     = var.enabled && try(var.iam_access.create_iam && var.iam_access.assume_role, false)
  create_iam_user     = var.enabled && try(var.iam_access.create_iam && !var.iam_access.assume_role, false)
  iam_policies        = concat([for index, bucket_name in var.bucket_names : templatefile("${path.module}/telestream_s3_permissions.json", { bucket_name = bucket_name, index = index })], var.iam_access.iam_policy_policies)
}

// Create the bucket 
resource "aws_s3_bucket" "bucket" {
  count         = var.enabled ? length(var.bucket_names) : 0
  bucket        = var.bucket_names[count.index]
  tags          = var.bucket_tags
  bucket_prefix = var.bucket_prefix
  force_destroy = var.force_destroy
  lifecycle {
    precondition {
      condition     = var.bucket_names[count.index] != null && var.bucket_prefix != null ? false : true
      error_message = "ERROR: Variables bucket_name and bucket_prefix conflict with each other. At least one of them must be set to null. If both are set to null the bucket name will be assigned a random, unique name ex:terraform-20230309175457926400000001"
    }
  }
}

// block public access
resource "aws_s3_bucket_public_access_block" "block_access" {
  count                   = var.enabled ? length(var.bucket_names) : 0
  bucket                  = element(aws_s3_bucket.bucket.*.id, count.index)
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  restrict_public_buckets = var.restrict_public_buckets
  ignore_public_acls      = var.ignore_public_acls
  depends_on              = [aws_s3_bucket.bucket]
}

// set object ownership based on access to bucket
resource "aws_s3_bucket_ownership_controls" "ownership" {
  count  = var.enabled ? length(var.bucket_names) : 0
  bucket = element(aws_s3_bucket.bucket.*.id, count.index)

  rule {
    object_ownership = local.s3_object_ownership
  }
}



