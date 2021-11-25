data "aws_iam_policy_document" "databricks_cross_account_policy" {
  statement {
    sid    = "NonResourceBasedPermissions"
    effect = "Allow"
    actions = [
      "ec2:CancelSpotInstanceRequests",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeIamInstanceProfileAssociations",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeInstances",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribePrefixLists",
      "ec2:DescribeReservedInstancesOfferings",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSpotInstanceRequests",
      "ec2:DescribeSpotPriceHistory",
      "ec2:DescribeSubnets",
      "ec2:DescribeVolumes",
      "ec2:DescribeVpcAttribute",
      "ec2:DescribeVpcs",
      "ec2:CreateTags",
      "ec2:DeleteTags",
      "ec2:RequestSpotInstances"
    ]
    resources = [
      "*"
    ]
  }

  statement {
    sid    = "InstancePoolsSupport"
    effect = "Allow"
    actions = [
      "ec2:AssociateIamInstanceProfile",
      "ec2:DisassociateIamInstanceProfile",
      "ec2:ReplaceIamInstanceProfileAssociation"
    ]
    resources = ["arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid     = "AllowEc2RunInstancePerTag"
    effect  = "Allow"
    actions = ["ec2:RunInstances"]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:volume/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid     = "AllowEc2RunInstanceImagePerTag"
    effect  = "Allow"
    actions = ["ec2:RunInstances"]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:image/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid     = "AllowEc2RunInstancePerVPC"
    effect  = "Allow"
    actions = ["ec2:RunInstances"]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:network-interface/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:subnet/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:security-group/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:vpc"
      values   = ["arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:vpc/${var.vpc_id}"]
    }
  }

  statement {
    sid     = "AllowEc2RunInstanceOtherResources"
    effect  = "Allow"
    actions = ["ec2:RunInstances"]
    not_resources = [
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:image/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:network-interface/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:subnet/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:security-group/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:volume/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/*"
    ]
  }

  statement {
    sid     = "EC2TerminateInstancesTag"
    effect  = "Allow"
    actions = ["ec2:TerminateInstances"]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid    = "EC2AttachDetachVolumeTag"
    effect = "Allow"
    actions = [
      "ec2:AttachVolume",
      "ec2:DetachVolume"
    ]
    resources = [
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:instance/*",
      "arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:volume/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid       = "EC2CreateVolumeByTag"
    effect    = "Allow"
    actions   = ["ec2:CreateVolume"]
    resources = ["arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:volume/*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    sid       = "EC2DeleteVolumeByTag"
    effect    = "Allow"
    actions   = ["ec2:DeleteVolume"]
    resources = ["arn:aws:ec2:${var.aws_region}:${var.aws_account_id}:volume/*"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }

  statement {
    effect = "Allow"
    actions = [
      "iam:CreateServiceLinkedRole",
      "iam:PutRolePolicy"
    ]
    resources = ["arn:aws:iam::*:role/aws-service-role/spot.amazonaws.com/AWSServiceRoleForEC2Spot"]
    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/Vendor"
      values   = ["Databricks"]
    }
  }
}

resource "aws_iam_role_policy" "this" {
  name   = "${var.prefix}-cross-account-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = data.aws_iam_policy_document.databricks_cross_account_policy.json
}