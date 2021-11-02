
provider "aws" {
  region = "eu-west-1"
}

module "storage" {
  source = "../../../aws-s3-bucket"

  bucket_name   = var.name
  force_destroy = true
  tags          = var.tags

  lifecycle_rule = [
    {
      id      = "cloudtrail"
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

module "cloudtrail" {
  source = "../../"

  name = var.name

  s3_bucket_name                = module.storage.s3_bucket_id
  enable_logging                = var.enable_logging
  include_global_service_events = var.include_global_service_events
  is_multi_region_trail         = var.is_multi_region_trail
  enable_log_file_validation    = var.enable_log_file_validation

  event_selector = [
    {
      read_write_type           = "All"
      include_management_events = true

      data_resource = [
        {
          type   = "AWS::Lambda::Function"
          values = ["arn:aws:lambda"]
        }
      ]
    },
    {
      read_write_type           = "All"
      include_management_events = true

      data_resource = [
        {
          type   = "AWS::S3::Object"
          values = ["arn:aws:s3:::"]
        }
      ]
    },
  ]

  tags = var.tags
}
