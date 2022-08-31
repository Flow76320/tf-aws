locals {

  asset_type = "eks"

  cluster_name = "${local.asset_type}-${var.region}-${random_string.suffix.result}"

  default_tags = {
    service = "eks"
  }
  tags = merge(local.default_tags, var.tags)
}
