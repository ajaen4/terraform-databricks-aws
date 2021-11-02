##### META INSTANCE PROFILE #####
resource "databricks_instance_profile" "meta_role" {
  instance_profile_arn = var.meta_role_arn
  is_meta_instance_profile = true
}

##### READ DATA INSTANCE PROFILE #####
resource "databricks_instance_profile" "data_read_role" {
  instance_profile_arn = var.data_read_role_arn
  skip_validation = true
}

resource "databricks_group_instance_profile" "meta_read_role_attachment" {
  group_id            = databricks_group.read_only.id
  instance_profile_id = databricks_instance_profile.data_read_role.id
}

##### READ DATA INSTANCE PROFILE #####
resource "databricks_instance_profile" "data_write_role" {
  instance_profile_arn = var.data_write_role_arn
  skip_validation = true
}

resource "databricks_group_instance_profile" "meta_write_role_attachment" {
  group_id            = databricks_group.all_access.id
  instance_profile_id = databricks_instance_profile.data_write_role.id
}