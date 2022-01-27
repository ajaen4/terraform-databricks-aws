data "aws_caller_identity" "current" {}

locals {
  account_id = data.aws_caller_identity.current.account_id

  # Account IDs that will have access to stream CloudTrail logs
  account_ids = concat([local.account_id], var.allowed_account_ids)

  # Format account IDs into necessary resource lists.
  iam_account_principals = formatlist("arn:aws:iam::%s:root", local.account_ids)

  s3_bucket = format(
    "${var.tags.region}-${var.tags.company}-${var.tags.project}-${var.bucket}",
  )

  kms_alias = format(
    "${var.tags.region}-${var.tags.company}-${var.tags.project}-${var.kms_alias_name}-kms01-${var.tags.environment}",
  )

  # Resolve resource names
  bucket     = try(local.s3_bucket, var.remote_bucket)
  kms_key_id = try(aws_kms_key.this[0].arn, var.kms_key_id)
}

resource "aws_s3_bucket" "this" {
  count  = var.remote_bucket == "" ? 1 : 0
  bucket = local.bucket
  acl    = "log-delivery-write"
  tags = merge(
    var.tags,
    {
      "Name" = local.bucket
    },
  )

  versioning {
    enabled = true
  }

  lifecycle_rule {
    id      = "expire"
    enabled = true

    noncurrent_version_expiration {
      days = 90
    }
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = "aws:kms"
        kms_master_key_id = local.kms_key_id
      }
    }
  }

  logging {
    target_bucket = coalesce(var.logging_target_bucket, local.bucket)
    target_prefix = var.logging_target_prefix
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  depends_on              = [aws_s3_bucket_policy.this]
  count                   = var.remote_bucket == "" ? 1 : 0
  bucket                  = aws_s3_bucket.this[0].id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_dynamodb_table" "this" {
  name           = var.table
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = merge(
    var.tags,
    {
      "Name" = "tf-locktable"
    },
  )
}

data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::${local.bucket}"
    ]

    principals {
      type        = "AWS"
      identifiers = local.iam_account_principals
    }
  }

  dynamic "statement" {
    for_each = var.allowed_account_ids

    content {
      effect    = "Allow"
      resources = ["arn:aws:s3:::${local.bucket}/${statement.value}/*"]
      actions = [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ]

      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${statement.value}:root"]
      }
    }
  }
}

resource "aws_s3_bucket_policy" "this" {
  count  = var.remote_bucket == "" ? 1 : 0
  bucket = aws_s3_bucket.this[0].id
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "key" {
  statement {
    actions   = ["kms:*"]
    effect    = "Allow"
    resources = ["*"]
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${local.account_id}:root"]
    }
  }

  dynamic "statement" {
    for_each = var.allowed_account_ids

    content {
      effect    = "Allow"
      resources = ["*"]
      actions = [
        "kms:Encrypt*",
        "kms:Decrypt*",
        "kms:ReEncrypt*",
        "kms:GenerateDataKey*",
        "kms:DescribeKey",
      ]
      principals {
        type        = "AWS"
        identifiers = ["arn:aws:iam::${statement.value}:root"]
      }
    }
  }
}

resource "aws_kms_key" "this" {
  count                   = var.kms_key_id == "" ? 1 : 0
  deletion_window_in_days = 7
  description             = "Terraform State KMS key"
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.key.json
  tags = merge(
    {
      "Name" = var.kms_alias_name != "" ? local.kms_alias : "tf_backend_key"
    },
    var.tags
  )
}

resource "aws_kms_alias" "this" {
  count         = var.kms_key_id == "" ? 1 : 0
  name          = "alias/${var.kms_alias_name != "" ? local.kms_alias : "tf_backend_key"}"
  target_key_id = aws_kms_key.this[0].id
}
