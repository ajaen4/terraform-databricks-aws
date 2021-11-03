##### META INSTANCE PROFILE #####
resource "databricks_instance_profile" "meta_role" {
  instance_profile_arn = var.meta_instance_profile_arn
  is_meta_instance_profile = true
}