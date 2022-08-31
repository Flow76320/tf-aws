locals {
  default_tags = {}

  tags = merge(local.default_tags, var.tags)
}
