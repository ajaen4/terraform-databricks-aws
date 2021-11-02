
######
# AWS CloudTrail Module
######

locals {
  resource_name = format(
    "${local.resource_prefix}-%s-trail01-%s",
    var.name,
    var.tags.environment,
  )
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_s3_bucket" "selected" {
  bucket = var.s3_bucket_name
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.create_trail ? 1 : 0

  name              = "/aws/cloudtrails/"
  retention_in_days = var.retention_in_days
  kms_key_id        = var.kms_key_arn

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "cloudwatch_log",
    }
  )
}

resource "aws_cloudwatch_log_stream" "this" {
  count = var.create_trail ? 1 : 0

  name           = format("%s_CloudTrail_%s", data.aws_caller_identity.current.account_id, data.aws_region.current.name)
  log_group_name = aws_cloudwatch_log_group.this[0].name
}

resource "aws_cloudtrail" "this" {
  count = var.create_trail ? 1 : 0

  name = local.resource_name

  s3_bucket_name = data.aws_s3_bucket.selected.id
  s3_key_prefix  = var.s3_key_prefix

  cloud_watch_logs_role_arn     = aws_iam_role.trail[0].arn
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.this[0].arn}:*"
  enable_logging                = var.enable_logging
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  is_organization_trail         = var.is_organization_trail
  sns_topic_name                = var.sns_topic_name
  enable_log_file_validation    = var.enable_log_file_validation

  dynamic "event_selector" {
    for_each = var.event_selector

    content {
      read_write_type           = lookup(event_selector.value, "read_write_type", null)
      include_management_events = lookup(event_selector.value, "include_management_events", null)

      dynamic "data_resource" {
        for_each = lookup(event_selector.value, "data_resource", [])

        content {
          type   = lookup(data_resource.value, "type", null)
          values = lookup(data_resource.value, "values", null)
        }
      }
    }
  }

  kms_key_id = var.kms_key_arn

  depends_on = [aws_s3_bucket_policy.trail]

  tags = merge(
    var.tags,
    {
      "resource_name" = local.resource_name,
      "resource_type" = "cloudtrail",
    }
  )
}

data "aws_iam_policy_document" "trail" {
  count = var.create_trail ? 1 : 0

  statement {
    sid = "AWSCloudTrailAclCheck"

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:GetBucketAcl",
    ]

    resources = [
      "${data.aws_s3_bucket.selected.arn}",
    ]
  }

  statement {
    sid = "AWSCloudTrailBucketDelivery"

    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${data.aws_s3_bucket.selected.arn}/*",
    ]

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"

      values = [
        "bucket-owner-full-control",
      ]
    }
  }

  statement {
    sid = "Allow write guardduty"
    actions = [
      "s3:PutObject",
      "s3:GetBucketLocation"
    ]

    resources = [
      "${data.aws_s3_bucket.selected.arn}/guardduty/*",
      data.aws_s3_bucket.selected.arn
    ]

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }
  }

  statement {
    sid = "AWSLogDeliveryWrite"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["${data.aws_s3_bucket.selected.arn}/AWSLogs/*"]
  }

  statement {
    sid = "AWSLogDeliveryAclCheck"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:GetBucketAcl"]

    resources = ["${data.aws_s3_bucket.selected.arn}"]
  }

  statement {
    sid    = "denyInsecureTransport"
    effect = "Deny"

    actions = [
      "s3:*",
    ]

    resources = [
      "${data.aws_s3_bucket.selected.arn}",
      "${data.aws_s3_bucket.selected.arn}/*",
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

resource "aws_s3_bucket_policy" "trail" {
  count = var.create_trail ? 1 : 0

  bucket = data.aws_s3_bucket.selected.id
  policy = data.aws_iam_policy_document.trail[0].json
}
