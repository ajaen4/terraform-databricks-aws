
provider "aws" {
  region = "eu-west-1"
}

data "null_data_source" "file" {
  inputs = {
    filename = "../../examples/dummy/functions/hello_world.py"
  }
}

data "null_data_source" "archive" {
  inputs = {
    filename = "../../examples/dummy/functions/hello_world.zip"
  }
}

data "archive_file" "dummy" {
  type = "zip"

  source_file = data.null_data_source.file.outputs.filename
  output_path = data.null_data_source.archive.outputs.filename
}

module "hello_world" {
  source = "../../"

  filename = data.archive_file.dummy.output_path

  function_name = var.function_name

  handler           = var.handler
  source_code_hash  = data.archive_file.dummy.output_base64sha256
  runtime           = var.runtime
  description       = var.description
  retention_in_days = var.retention_in_days
  timeout           = var.timeout
  tags              = var.tags
}
