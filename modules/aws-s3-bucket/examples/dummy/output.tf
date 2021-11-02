
output "dummy_s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = module.s3_bucket.s3_bucket_id
}
