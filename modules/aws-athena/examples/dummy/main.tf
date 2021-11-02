
provider "aws" {
  region = "eu-west-1"
}

module "origin" {
  source = "../../../aws-s3-bucket"

  bucket_name   = var.name
  force_destroy = true
  tags          = var.tags

  lifecycle_rule = [
    {
      id      = "athena"
      enabled = true

      transition = [
        {
          days          = 20
          storage_class = "GLACIER"
        }
      ]

      expiration = [
        {
          days = 180
        }
      ]
    },
  ]
}

resource "aws_s3_bucket_object" "object" {
  bucket = module.origin.s3_bucket_id
  key    = "dummy.json"
  source = "dummy.json"
}

module "engine" {
  source = "../../"

  enforce_config      = var.enforce_config
  catalog_name        = var.catalog_name
  catalog_description = var.catalog_description
  s3_bucket_name      = module.origin.s3_bucket_id
  name                = var.name

  queries = [
    {
      name        = "dummy-athena"
      description = "The query ... dummy"
      query       = "SELECT * FROM athena_example_20191106"
    },
  ]

  tags = var.tags
}
