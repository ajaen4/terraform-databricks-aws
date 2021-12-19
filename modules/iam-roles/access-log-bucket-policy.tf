data "aws_iam_policy_document" "access_log_bucket" {

  statement {
    sid       = "listBucket"
    effect    = "Allow"
    resources = [var.s3_databricks_log_bucket_arn]

    actions = [
      "s3:ListBucket"
    ]
  }

  statement {
    sid    = "readWriteObjects"
    effect = "Allow"
    resources = [
      "${var.s3_databricks_log_bucket_arn}/*"
    ]

    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:PutObjectAcl"
    ]
  }
}

resource "aws_iam_policy" "access_log_bucket_policy" {
  name        = "${var.prefix}-logBucketPolicy"
  path        = "/"
  description = "Access log bucket policy"

  policy = data.aws_iam_policy_document.access_log_bucket.json
}