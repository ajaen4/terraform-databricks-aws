data "databricks_aws_assume_role_policy" "this" {
  external_id = var.databricks_account_id
}

resource "time_sleep" "wait" {
  depends_on      = [aws_iam_role.cross_account_role]
  create_duration = "10s"
}

resource "aws_iam_role" "cross_account_role" {
  name               = "${var.prefix}-cross-account-role"
  assume_role_policy = data.databricks_aws_assume_role_policy.this.json
  tags               = var.tags
}

data "aws_iam_policy_document" "cross_account_assume_meta_policy" {

  statement {
    sid    = "PassMetaRole"
    effect = "Allow"
    resources = [
      aws_iam_role.meta_role.arn
    ]

    actions = [
      "iam:PassRole"
    ]
  }
}

resource "aws_iam_policy" "cross_acc_assume_meta_policy" {
  name        = "${var.prefix}-CrossAccAssumeMeta"
  path        = "/"
  description = "Cross Account assume Meta role policy"

  policy = data.aws_iam_policy_document.cross_account_assume_meta_policy.json
}

resource "aws_iam_role_policy_attachment" "cross_account_meta_role_attachment" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_policy.cross_acc_assume_meta_policy.arn
}

##### META ROLE ######

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

resource "aws_iam_role" "meta_role" {
  name = "${var.prefix}-meta_role"

  assume_role_policy = data.aws_iam_policy_document.meta_assume_policy_doc.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "meta_role_attachment" {
  role       = aws_iam_role.meta_role.name
  policy_arn = aws_iam_policy.meta_role_policy.arn
}

resource "aws_iam_instance_profile" "meta_instance_profile" {
  name = "${var.prefix}-meta_instance_profile"
  role = aws_iam_role.meta_role.name
}

##### GLUE POLICIES ######

data "aws_iam_policy_document" "glue_access_policy" {

  statement {
    sid    = "GrantFullAccessToGlue"
    effect = "Allow"
    resources = [
      "*"
    ]

    actions = [
      "glue:BatchCreatePartition",
      "glue:BatchDeletePartition",
      "glue:BatchGetPartition",
      "glue:CreateDatabase",
      "glue:CreateTable",
      "glue:CreateUserDefinedFunction",
      "glue:DeleteDatabase",
      "glue:DeletePartition",
      "glue:DeleteTable",
      "glue:DeleteUserDefinedFunction",
      "glue:GetDatabase",
      "glue:GetDatabases",
      "glue:GetPartition",
      "glue:GetPartitions",
      "glue:GetTable",
      "glue:GetTables",
      "glue:GetUserDefinedFunction",
      "glue:GetUserDefinedFunctions",
      "glue:UpdateDatabase",
      "glue:UpdatePartition",
      "glue:UpdateTable",
      "glue:UpdateUserDefinedFunction"
    ]
  }
}

resource "aws_iam_policy" "glue_access_policy" {
  name        = "${var.prefix}-glueAccessPolicy"
  path        = "/"
  description = "Glue role policy"

  policy = data.aws_iam_policy_document.glue_access_policy.json
}

##### DATA READ ROLE ######

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

resource "aws_iam_role" "s3_datalake_read_role" {
  name = "${var.prefix}-s3_datalake_read_role"

  assume_role_policy = data.aws_iam_policy_document.data_role_assume_policy_doc.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "data_read_role_attachment" {
  role       = aws_iam_role.s3_datalake_read_role.name
  policy_arn = aws_iam_policy.data_read_role_policy.arn
}

resource "aws_iam_instance_profile" "data_read_instance_profile" {
  name = "${var.prefix}-read_instance_profile"
  role = aws_iam_role.s3_datalake_read_role.name
}

##### DATA WRITE ROLE ######

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

resource "aws_iam_role" "s3_datalake_write_role" {
  name = "${var.prefix}-s3_datalake_write_role"

  assume_role_policy = data.aws_iam_policy_document.data_role_assume_policy_doc.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "data_write_role_attachment" {
  role       = aws_iam_role.s3_datalake_write_role.name
  policy_arn = aws_iam_policy.data_write_role_policy.arn
}

resource "aws_iam_role_policy_attachment" "write_role_glue_attachment" {
  role       = aws_iam_role.s3_datalake_write_role.name
  policy_arn = aws_iam_policy.glue_access_policy.arn
}

resource "aws_iam_instance_profile" "data_write_instance_profile" {
  name = "${var.prefix}-write_instance_profile"
  role = aws_iam_role.s3_datalake_write_role.name
}