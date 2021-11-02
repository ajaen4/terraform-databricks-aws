
output "dummy_trail_id" {
  description = "The name of the trail"
  value       = module.cloudtrail.trail_id
}

output "dummy_trail_home_region" {
  description = "The region in which the trail was created"
  value       = module.cloudtrail.trail_home_region
}

output "dummy_trail_arn" {
  description = "The Amazon Resource Name of the trail"
  value       = module.cloudtrail.trail_arn
}

output "dummy_trial_s3_bucket_id" {
  description = "Name of the S3 trail bucket"
  value       = module.storage.s3_bucket_id
}

output "dummy_trial_s3_bucket_domain_name" {
  description = "The FQDN of the CloudTrial bucket"
  value       = module.storage.s3_bucket_domain_name
}

output "dummy_trial_s3_bucket_arn" {
  description = "ARN of the CloudTrial bucket"
  value       = module.storage.s3_bucket_arn
}
