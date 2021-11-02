
######
# aws_s3_bucket
######

output "s3_bucket_arn" {
  description = "Amazon Resource Name (ARN) of the S3 bucket"
  value       = concat(aws_s3_bucket.this.*.arn, [""])[0]
}

output "s3_bucket_id" {
  description = "The ID of the S3 bucket"
  value       = concat(aws_s3_bucket.this.*.id, [""])[0]
}

output "s3_bucket_domain_name" {
  description = "The S3 bucket domain name"
  value       = concat(aws_s3_bucket.this.*.bucket_domain_name, [""])[0]
}

output "s3_bucket_regional_domain_name" {
  description = "The S3 bucket region-specific domain name"
  value       = concat(aws_s3_bucket.this.*.bucket_regional_domain_name, [""])[0]
}

output "s3_bucket_hosted_zone_id" {
  description = "The Route 53 Hosted Zone ID for this bucket's region"
  value       = concat(aws_s3_bucket.this.*.hosted_zone_id, [""])[0]
}

output "s3_bucket_region" {
  description = "The AWS region this bucket resides in"
  value       = concat(aws_s3_bucket.this.*.region, [""])[0]
}
