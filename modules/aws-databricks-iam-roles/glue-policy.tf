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