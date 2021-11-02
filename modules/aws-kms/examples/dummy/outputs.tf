
output "dummy_kms_arn" {
  description = "The Amazon Resource Name (ARN) of the key"
  value       = module.kms_key.kms_arn
}

output "dummy_kms_key_id" {
  description = "The globally unique identifier for the key"
  value       = module.kms_key.kms_key_id
}

output "dummy_kms_alias_arn" {
  description = "The Amazon Resource Name (ARN) of the key alias"
  value       = module.kms_key.kms_alias_arn
}

output "dummy_kms_alias_name" {
  description = "The display name of the alias"
  value       = module.kms_key.kms_alias_name
}
