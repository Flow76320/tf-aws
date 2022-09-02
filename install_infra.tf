# Create required VPC for EKS
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
}

# Create EKS cluster and its workers
module "eks" {
  source = "./modules/eks"

  # Global config
  region        = var.region
  dns_zone_name = var.dns_zone_name

  # Network config
  eks_vpc_id                 = module.vpc.vpc_id
  vpc_default_route_table_id = module.vpc.vpc_default_route_table_id
  eks_cidr_block_primary     = var.eks_cidr_block_primary
  eks_cidr_block_secondary   = var.eks_cidr_block_secondary
}

# Install Helm releases workload to EKS cluster
module "helm" {
  source = "./modules/helm"

  dns_domain = var.dns_zone_name
  # No additional parametrization is done. We could expose variables to update Helm Charts values/versions for example.

  depends_on = [
    module.eks
  ]
}
