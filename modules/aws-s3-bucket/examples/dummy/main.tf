
provider "aws" {
  region = "eu-west-1"
}

module "s3_bucket" {
  source = "../.."

  bucket_name   = var.bucket_name
  acl           = var.acl
  force_destroy = var.force_destroy
  versioning    = var.versioning
  sse_prevent   = var.sse_prevent
  tags          = var.tags

  lifecycle_rule = [
    {
      id      = "test-rule"
      enabled = true

      transition = [
        {
          days          = 30
          storage_class = "STANDARD_IA"
        },
        {
          days          = 60
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
