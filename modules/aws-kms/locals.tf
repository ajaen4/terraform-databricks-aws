
locals {
  resource_prefix = format("${var.tags.region}-${var.tags.company}-${var.tags.project}")
}
