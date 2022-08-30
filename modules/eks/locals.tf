locals {

  asset_type = "eks"

  cluster_name = "${local.asset_type}-${var.region}-${random_string.suffix.result}"
}
