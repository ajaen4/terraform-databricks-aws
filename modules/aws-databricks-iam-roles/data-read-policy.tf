data "aws_iam_policy_document" "data_role_assume_policy_doc" {

  statement {
    sid    = "allowMetaRole"
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [aws_iam_role.meta_role.arn]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }

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

data "aws_iam_policy_document" "data_role_read_policy_doc" {

  statement {
    sid       = "listBucket"
    effect    = "Allow"
    resources = [var.s3_data_bucket_arn]

    actions = [
      "s3:ListBucket"
    ]
  }

  statement {
    sid    = "readObjects"
    effect = "Allow"
    resources = [
      "${var.s3_data_bucket_arn}/*"
    ]

    actions = [
      "s3:GetObject"
    ]
  }
}

resource "aws_iam_policy" "data_read_role_policy" {
  name        = "${var.prefix}-dataReadRolePolicy"
  path        = "/"
  description = "Data read role policy"

  policy = data.aws_iam_policy_document.data_role_read_policy_doc.json
}
