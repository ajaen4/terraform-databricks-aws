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

resource "aws_iam_role_policy_attachment" "cross_account_meta_role_attachment" {
  role       = aws_iam_role.cross_account_role.name
  policy_arn = aws_iam_policy.cross_acc_assume_meta_policy.arn
}

##### DATABRICKS AUDIT AND BILLABLE LOGS ROLE #####

data "databricks_aws_assume_role_policy" "log_delivery" {
  external_id      = var.databricks_account_id
  for_log_delivery = true
}

resource "aws_iam_role" "log_delivery" {
  name               = "${var.prefix}-log-delivery"
  description        = "(${var.prefix}) Usage and Audit delivery role"
  assume_role_policy = data.databricks_aws_assume_role_policy.log_delivery.json
  tags               = var.tags
}

resource "aws_iam_role_policy_attachment" "databricks_log_role_attachment" {
  role       = aws_iam_role.log_delivery.name
  policy_arn = aws_iam_policy.access_log_bucket_policy.arn
}

##### META ROLE ######

resource "aws_iam_role" "meta_role" {
  name = "${var.prefix}-meta_role"

  assume_role_policy = data.aws_iam_policy_document.meta_assume_policy_doc.json

  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "databricks_meta_log_role_attachment" {
  role       = aws_iam_role.meta_role.name
  policy_arn = aws_iam_policy.access_log_bucket_policy.arn
}

resource "aws_iam_role_policy_attachment" "meta_role_attachment" {
  role       = aws_iam_role.meta_role.name
  policy_arn = aws_iam_policy.meta_role_policy.arn
}

resource "aws_iam_instance_profile" "meta_instance_profile" {
  name = "${var.prefix}-meta_instance_profile"
  role = aws_iam_role.meta_role.name
}

##### DATA READ ROLE ######

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