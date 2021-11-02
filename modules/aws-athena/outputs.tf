
######
# aws_athena_workgroup
######

output "athena_wg_id" {
  description = "The workgroup name"
  value       = concat(aws_athena_workgroup.this.*.id, [""])[0]
}

output "athena_wg_arn" {
  description = "The ARN of workgroup"
  value       = concat(aws_athena_workgroup.this.*.arn, [""])[0]
}

######
# aws_glue_crawler
######

output "athena_crawler_id" {
  description = "The glue crawler identifier"
  value       = concat(aws_glue_crawler.this.*.id, [""])[0]
}

output "athena_crawler_arn" {
  description = "The ARN of glue crawler"
  value       = concat(aws_glue_crawler.this.*.arn, [""])[0]
}
