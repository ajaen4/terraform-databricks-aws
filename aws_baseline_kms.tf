data "aws_iam_policy_document" "aws_baseline_kms_document" {

  statement {
    sid    = "Enable IAM User Permissions"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["logs.${var.aws_region}.amazonaws.com"]
    }

    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "kms:GenerateDataKey*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudwatch.amazonaws.com"]
    }

    actions = [
      "kms:GenerateDataKey*",
      "kms:Decrypt"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["guardduty.amazonaws.com"]
    }

    actions = [
      "kms:GenerateDataKey*"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "Allow Databricks to use KMS key for DBFS"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::414351767826:root"]
    }
    actions = [
      "kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:DescribeKey"
    ]
    resources = ["*"]
  }

  statement {
    sid    = "Allow Databricks to use KMS key for DBFS (Grants)"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::414351767826:root"]
    }
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    resources = ["*"]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
  statement {
    sid    = "Allow Databricks to use KMS key for EBS"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [module.iam_databricks_roles.cross_account_role_arn]
    }
    actions = [
      "kms:Decrypt",
      "kms:GenerateDataKey*",
      "kms:CreateGrant",
      "kms:DescribeKey"
    ]
    resources = ["*"]
    condition {
      test     = "ForAnyValue:StringLike"
      variable = "kms:ViaService"
      values   = ["ec2.*.amazonaws.com"]
    }
  }
}

module "aws_baseline_kms" {
  source = "./modules/aws-kms"

  create_key              = var.aws_baseline_kms.create_key
  deletion_window_in_days = var.aws_baseline_kms.deletion_window_in_days
  description             = var.aws_baseline_kms.description
  enable_key_rotation     = var.aws_baseline_kms.enable_key_rotation
  enabled                 = var.aws_baseline_kms.enabled
  is_enabled              = var.aws_baseline_kms.is_enabled
  key_usage               = var.aws_baseline_kms.key_usage
  name                    = var.aws_baseline_kms.name
  policy                  = data.aws_iam_policy_document.aws_baseline_kms_document.json
  tags                    = var.tags
}
