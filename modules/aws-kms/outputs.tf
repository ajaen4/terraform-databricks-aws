
######
# aws_kms_key
######

output "kms_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = concat(aws_kms_key.this.*.arn, [""])[0]
}

output "kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = concat(aws_kms_key.this.*.key_id, [""])[0]
}

output "kms_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias"
  value       = concat(aws_kms_alias.internal.*.arn, [""])[0]
}

output "kms_alias_name" {
  description = "The display name of the key alias"
  value       = concat(aws_kms_alias.internal.*.name, [""])[0]
}

######
# aws_kms_external_key
######

output "kms_external_arn" {
  description = "The Amazon Resource Name (ARN) of the external key"
  value       = concat(aws_kms_external_key.this.*.arn, [""])[0]
}

output "kms_external_key_id" {
  description = "The globally unique identifier for the external key"
  value       = concat(aws_kms_external_key.this.*.key_id, [""])[0]
}

output "kms_external_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the external key alias"
  value       = concat(aws_kms_alias.external.*.arn, [""])[0]
}

output "kms_external_alias_name" {
  description = "The display name of the external key alias"
  value       = concat(aws_kms_alias.external.*.name, [""])[0]
}
