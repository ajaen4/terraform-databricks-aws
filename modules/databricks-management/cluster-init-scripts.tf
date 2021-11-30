resource "databricks_dbfs_file" "core_site_config" {
  provider = databricks.pat_token
  content_base64 = base64encode(
    templatefile("${path.root}/config-files/core-site.tpl", { kms_key_arn = var.datalake_key_arn })
  )
  path = "/tmp/core-site.xml"
}

resource "databricks_global_init_script" "encryption_init_script" {
  provider = databricks.service_ppal
  source   = "${path.root}/config-files/init.sh"
  name     = "encryption_init_script"
  enabled  = true
}