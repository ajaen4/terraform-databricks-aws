
output "dummy_origin_s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.origin.s3_bucket_id
}

output "dummy_origin_s3_bucket_arn" {
  description = "Amazon Resource Name (ARN) of the S3 bucket"
  value       = module.origin.s3_bucket_arn
}

output "dummy_athena_wg_id" {
  description = "The workgroup name"
  value       = module.engine.athena_wg_id
}

output "dummy_athena_wg_arn" {
  description = "The Amazon Resource Name (ARN) of the workgroup"
  value       = module.engine.athena_wg_arn
}

output "dummy_athena_crawler_id" {
  description = "The glue crawler identifier"
  value       = module.engine.athena_crawler_id
}

output "dummy_athena_crawler_arn" {
  description = "The Amazon Resource Name (ARN) of the glue crawler"
  value       = module.engine.athena_crawler_arn
}
