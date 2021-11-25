##### META INSTANCE PROFILE #####
resource "databricks_instance_profile" "meta_role" {
  instance_profile_arn     = var.meta_instance_profile_arn
  is_meta_instance_profile = true
  // Necessary because the Dry-run test is done without the "vendor:Databricks" tag,
  // resulting in an error
  skip_validation = true
}