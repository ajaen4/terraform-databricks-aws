data "databricks_aws_assume_role_policy" "this" {
  external_id = var.databricks_account_id
}

resource "aws_iam_role" "cross_account_role" {
  name               = "${var.prefix}-cross-account-role"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.tags
}

resource "time_sleep" "wait" {
  depends_on = [aws_iam_role.cross_account_role]
  create_duration = "10s"
}

data "databricks_aws_crossaccount_policy" "this" {}

resource "aws_iam_role_policy" "this" {
  name   = "${var.prefix}-cross-account-policy"
  role   = aws_iam_role.cross_account_role.id
  policy = data.databricks_aws_crossaccount_policy.this.json
}

##### META ROLE ######

data "aws_iam_policy_document" "meta_assume_policy_doc" {

  statement {
    sid       = "EC2AssumeRole"
    effect    = "Allow"
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = [
      "sts:AssumeRole"
    ]
  }
}

data "aws_iam_policy_document" "meta_assume_data_roles_policy" {

  statement {
    sid       = "AssumeDataRoles"
    effect    = "Allow"
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
  name        = "metaRolePolicy"
  path        = "/"
  description = "Meta role policy"

  policy = data.aws_iam_policy_document.meta_assume_data_roles_policy.json
}

resource "aws_iam_role" "meta_role" {
  name                = "${var.prefix}-meta_role"

  assume_role_policy = data.aws_iam_policy_document.meta_assume_policy_doc.json

  tags                = var.tags
}

resource "aws_iam_role_policy_attachment" "meta_role_attachment" {
  role       = aws_iam_role.meta_role.name
  policy_arn = aws_iam_policy.meta_role_policy.arn
}

##### DATA READ ROLE ######

data "aws_iam_policy_document" "data_role_assume_policy_doc" {

  statement {
    sid       = "allowMetaRole"
    effect    = "Allow"

    principals {
      type = "AWS"
      identifiers = [aws_iam_role.meta_role.arn]
    } 

    actions = [
      "sts:AssumeRole"
    ]
  }

  statement {
    sid       = "EC2AssumeRole"
    effect    = "Allow"
    principals {
      type = "Service"
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
    resources = [aws_s3_bucket.data_bucket.arn]

    actions = [
      "s3:ListBucket"
    ]
  }

  statement {
    sid    = "readObjects"
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.data_bucket.arn}/*"
    ]

    actions = [
      "s3:GetObject"
    ]
  }
}

resource "aws_iam_policy" "data_read_role_policy" {
  name        = "dataReadRolePolicy"
  path        = "/"
  description = "Data read role policy"

  policy = data.aws_iam_policy_document.data_role_read_policy_doc.json
}

resource "aws_iam_role" "s3_datalake_read_role" {
  name                     = "${var.prefix}-s3_datalake_read_role"

  assume_role_policy       = data.aws_iam_policy_document.data_role_assume_policy_doc.json
  
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "data_read_role_attachment" {
  role       = aws_iam_role.s3_datalake_read_role.name
  policy_arn = aws_iam_policy.data_read_role_policy.arn
}

##### DATA WRITE ROLE ######

data "aws_iam_policy_document" "write_role_read_policy_doc" {

  statement {
    sid       = "listBucket"
    effect    = "Allow"
    resources = [aws_s3_bucket.data_bucket.arn]

    actions = [
      "s3:ListBucket"
    ]
  }

  statement {
    sid    = "readWriteObjects"
    effect = "Allow"
    resources = [
      "${aws_s3_bucket.data_bucket.arn}/*"
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
  name        = "dataWriteRolePolicy"
  path        = "/"
  description = "Data write role policy"

  policy = data.aws_iam_policy_document.write_role_read_policy_doc.json
}

resource "aws_iam_role" "s3_datalake_write_role" {
  name                     = "${var.prefix}-s3_datalake_write_role"

  assume_role_policy       = data.aws_iam_policy_document.data_role_assume_policy_doc.json
  
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "data_write_role_attachment" {
  role       = aws_iam_role.s3_datalake_write_role.name
  policy_arn = aws_iam_policy.data_write_role_policy.arn
}