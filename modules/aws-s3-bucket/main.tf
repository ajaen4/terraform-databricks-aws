
######
# Amazon S3 Bucket
######

resource "aws_s3_bucket" "this" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = var.bucket_name

  force_destroy = var.force_destroy
  acl           = var.acl

  versioning {
    enabled = var.versioning
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
        kms_master_key_id = var.kms_master_key_arn
      }
    }
  }

  dynamic "logging" {
    for_each = length(keys(var.logging)) == 0 ? [] : [var.logging]

    content {
      target_bucket = logging.value.target_bucket
      target_prefix = lookup(logging.value, "target_prefix", null)
    }
  }

  dynamic "grant" {
    for_each = var.grant

    content {
      id          = lookup(grant.value, "id", null)
      type        = grant.value.type
      permissions = grant.value.permissions
      uri         = lookup(grant.value, "uri", null)
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule

    content {
      id      = lookup(lifecycle_rule.value, "id", null)
      enabled = lookup(lifecycle_rule.value, "enabled", null)

      dynamic "transition" {
        for_each = lookup(lifecycle_rule.value, "transition", [])

        content {
          days          = lookup(transition.value, "days", null)
          storage_class = lookup(transition.value, "storage_class", null)
        }
      }

      dynamic "expiration" {
        for_each = lookup(lifecycle_rule.value, "expiration", [])

        content {
          days = lookup(expiration.value, "days", null)
        }
      }

      dynamic "noncurrent_version_expiration" {
        for_each = lookup(lifecycle_rule.value, "noncurrent_version_expiration", [])

        content {
          days = lookup(noncurrent_version_expiration.value, "days", null)
        }
      }

      dynamic "noncurrent_version_transition" {
        for_each = lookup(lifecycle_rule.value, "noncurrent_version_transition", [])

        content {
          days          = lookup(noncurrent_version_transition.value, "days", null)
          storage_class = lookup(noncurrent_version_transition.value, "storage_class", null)
        }
      }
    }
  }

  tags = merge(
    var.tags,
    {
      "resource_name" = var.bucket_name,
      "resource_type" = "s3",
    }
  )
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.create_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.this[0].id

  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

data "aws_iam_policy_document" "sse" {
  count = var.sse_prevent && var.create_s3_bucket ? 1 : 0

  statement {
    sid = ""

    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[0].id}/*",
    ]

    condition {
      test     = "Null"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        "true",
      ]
    }
  }

  statement {
    sid = ""

    effect = "Deny"

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[0].id}/*",
    ]

    condition {
      test     = "StringNotEquals"
      variable = "s3:x-amz-server-side-encryption"

      values = [
        var.sse_algorithm,
      ]
    }
  }

  statement {
    sid    = "denyInsecureTransport"
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${aws_s3_bucket.this[0].id}",
      "arn:aws:s3:::${aws_s3_bucket.this[0].id}/*",
    ]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "Bool"
      variable = "aws:SecureTransport"
      values = [
        "false"
      ]
    }
  }
}

resource "aws_s3_bucket_policy" "sse" {
  count = var.sse_prevent && var.create_s3_bucket ? 1 : 0

  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.sse[0].json

  depends_on = [aws_s3_bucket_public_access_block.this]
}
