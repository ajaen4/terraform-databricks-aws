data "aws_iam_policy_document" "databricks_storage_cmk" {
  version = "2012-10-17"

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

module "aws_datalake_kms" {
  source = "./modules/aws-kms"

  create_key              = var.aws_datalake_kms.create_key
  deletion_window_in_days = var.aws_datalake_kms.deletion_window_in_days
  description             = var.aws_datalake_kms.description
  enable_key_rotation     = var.aws_datalake_kms.enable_key_rotation
  enabled                 = var.aws_datalake_kms.enabled
  is_enabled              = var.aws_datalake_kms.is_enabled
  key_usage               = var.aws_datalake_kms.key_usage
  name                    = var.aws_datalake_kms.name
  policy                  = data.aws_iam_policy_document.databricks_storage_cmk.json
  tags                    = var.tags
}
