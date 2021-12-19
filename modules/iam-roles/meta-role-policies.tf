data "aws_iam_policy_document" "meta_assume_policy_doc" {

  statement {
    sid    = "EC2AssumeRole"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "meta_assume_data_roles_policy" {

  statement {
    sid    = "AssumeDataRoles"
    effect = "Allow"
    resources = [
      aws_iam_role.s3_datalake_read_role.arn,
      aws_iam_role.s3_datalake_write_role.arn
    ]

    actions = [
      "sts:AssumeRole"
    ]
  }
}

resource "aws_iam_policy" "meta_role_policy" {
  name        = "${var.prefix}-metaRolePolicy"
  path        = "/"
  description = "Meta role policy"

  policy = data.aws_iam_policy_document.meta_assume_data_roles_policy.json
}