resource "databricks_dbfs_file" "core_site_config" {
  content_base64 = base64encode(
    templatefile("${path.root}/config-files/core-site.tpl", { kms_key_arn = var.kms_key_arn_s3_enc })
  )
  path = "/tmp/core-site.xml"
}

resource "databricks_global_init_script" "encryption_init_script" {
  source  = "${path.root}/config-files/init.sh"
  name    = "encryption_init_script"
  enabled = true
}