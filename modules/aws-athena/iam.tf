
######
# Amazon IAM for Glue
######

data "aws_iam_policy_document" "assume_role_glue" {
  count = var.create_athena ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["glue.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "glue" {
  count = var.create_athena ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-role01-%s",
    var.name,
    var.tags.environment,
  )

  assume_role_policy = data.aws_iam_policy_document.assume_role_glue[0].json

  tags = merge(
    var.tags,
    {
      "resource_name" = local.glue_resource_name,
      "resource_type" = "iam_role",
    }
  )
}

resource "aws_iam_role_policy_attachment" "glue" {
  count = var.create_athena ? 1 : 0

  role       = aws_iam_role.glue[0].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSGlueServiceRole"
}

######
# Amazon IAM for Read Bucket
######

data "aws_iam_policy_document" "src" {
  count = var.create_athena ? 1 : 0

  statement {
    sid = "AWSGlueReadAccess"

    effect = "Allow"

    actions = [
      "s3:GetObject",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/*",
    ]
  }
}

resource "aws_iam_policy" "src" {
  count = var.create_athena ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-policy01-%s",
    var.name,
    var.tags.environment,
  )

  policy = data.aws_iam_policy_document.src[0].json
}

resource "aws_iam_role_policy_attachment" "src" {
  count = var.create_athena ? 1 : 0

  role       = aws_iam_role.glue[0].id
  policy_arn = aws_iam_policy.src[0].arn
}

######
# Amazon IAM for Athena
######

data "aws_iam_policy_document" "assume_role_athena" {
  count = var.create_athena ? 1 : 0

  statement {
    effect = "Allow"

    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["athena.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "athena" {
  count = var.create_athena ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-role02-%s",
    var.name,
    var.tags.environment,
  )

  assume_role_policy = data.aws_iam_policy_document.assume_role_athena[0].json

  tags = merge(
    var.tags,
    {
      "resource_name" = local.athena_workgroup_name,
      "resource_type" = "iam_role",
    }
  )
}

resource "aws_iam_role_policy_attachment" "athena" {
  count = var.create_athena ? 1 : 0

  role       = aws_iam_role.athena[0].name
  policy_arn = "arn:aws:iam::aws:policy/AmazonAthenaFullAccess"
}

######
# Amazon IAM for Write Bucket
######

data "aws_iam_policy_document" "dst" {
  count = var.create_athena ? 1 : 0

  statement {
    sid = "AWSAthenWriteAccess"

    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "arn:aws:s3:::${var.s3_bucket_name}/output/*",
    ]
  }
}

resource "aws_iam_policy" "dst" {
  count = var.create_athena ? 1 : 0

  name = format(
    "${local.resource_prefix}-%s-policy02-%s",
    var.name,
    var.tags.environment,
  )

  policy = data.aws_iam_policy_document.dst[0].json
}

resource "aws_iam_role_policy_attachment" "dst" {
  count = var.create_athena ? 1 : 0

  role       = aws_iam_role.athena[0].id
  policy_arn = aws_iam_policy.dst[0].arn
}
