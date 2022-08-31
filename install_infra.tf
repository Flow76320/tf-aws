module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.eks_cidr_block
}

module "eks" {
  source = "./modules/eks"

  # Global config
  region = var.region

  # Network config
  eks_vpc_id     = module.vpc.vpc_id
  eks_cidr_block = var.eks_cidr_block
}

# module "helm" {
#   source = "./modules/helm"
# }
