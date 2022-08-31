locals {

  asset_type = "eks"

  cluster_name = "${local.asset_type}-${var.region}-${random_string.suffix.result}"
  eks_sg       = format("sg_%s", local.cluster_name)

  my_public_ip_cidr = "${chomp(data.http.my_public_ip.body)}/32"

  default_tags = {
    service = "eks"
  }
  tags = merge(local.default_tags, var.tags)
}
