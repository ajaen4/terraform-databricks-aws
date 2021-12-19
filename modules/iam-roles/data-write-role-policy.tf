data "aws_iam_policy_document" "write_role_read_policy_doc" {

  statement {
    sid       = "listBucket"
    effect    = "Allow"
    resources = [var.s3_data_bucket_arn]

    actions = [
      "s3:ListBucket"
    ]
  }

  statement {
    sid    = "readWriteObjects"
    effect = "Allow"
    resources = [
      "${var.s3_data_bucket_arn}/*"
    ]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
  }
}

resource "aws_iam_policy" "data_write_role_policy" {
  name        = "${var.prefix}-dataWriteRolePolicy"
  path        = "/"
  description = "Data write role policy"

  policy = data.aws_iam_policy_document.write_role_read_policy_doc.json
}