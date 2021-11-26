##### META INSTANCE PROFILE #####
resource "databricks_instance_profile" "meta_role" {
  instance_profile_arn     = var.meta_instance_profile_arn
  is_meta_instance_profile = true
  // If the tag condition is present in the cross-account role it's
  // necessary to skip the validation. This is because it performs a dry-run
  // without this tag, resulting in a failed validation
  #skip_validation = true
}

resource "databricks_group_instance_profile" "admins_group_meta_role" {
    group_id = data.databricks_group.admins.id
    instance_profile_id = databricks_instance_profile.meta_role.id
}