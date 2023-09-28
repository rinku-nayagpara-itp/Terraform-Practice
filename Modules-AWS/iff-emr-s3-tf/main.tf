resource "aws_s3_bucket" "s3_bucket" {
  bucket        = var.bucket
  acl           = var.acl
  force_destroy = var.force_destroy
  tags          = var.tags

  dynamic "logging" {
    for_each = var.logging != null ? [1] : []
    content {
      target_bucket = var.logging.target_bucket
    }
  }

  dynamic "versioning" {
    for_each = var.versioning_enabled == true ? [1] : []
    content {
      enabled = true
    }
  }
  dynamic "server_side_encryption_configuration" {
    for_each = var.server_side_encryption_configuration != null ? [1] : []
    content {
      rule {
        apply_server_side_encryption_by_default {
          sse_algorithm = var.server_side_encryption_configuration.rule.apply_server_side_encryption_by_default.sse_algorithm
        }
      }
    }
  }
}

resource "aws_s3_object" "files_upload" {
  count  = length(var.file_key)
  bucket = aws_s3_bucket.s3_bucket.id
  key    = var.file_key[count.index]
  source = var.file_source[count.index]
}

resource "aws_s3_bucket_lifecycle_configuration" "this" {
  for_each = var.lifecycle_rules == null ? {} : { for idx, val in var.lifecycle_rules : idx => val }
  bucket   = aws_s3_bucket.s3_bucket.id
  dynamic "rule" {
    for_each = each.value.rule == null ? [] : each.value.rule
    content {
      status = rule.value.status
      id     = rule.value.id
      dynamic "transition" {
        for_each = rule.value.transition
        content {
          storage_class = transition.value.storage_class
          days          = transition.value.days
        }
      }
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = var.s3_public_access.block_public_acls
  block_public_policy     = var.s3_public_access.block_public_policy
  ignore_public_acls      = var.s3_public_access.ignore_public_acls
  restrict_public_buckets = var.s3_public_access.restrict_public_buckets
}
