# Create required VPC for EKS
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr_block = var.vpc_cidr_block
}

# Create EKS cluster and its workers
module "eks" {
  source = "./modules/eks"

  # Global config
  region = var.region

  # Network config
  eks_vpc_id                 = module.vpc.vpc_id
  vpc_default_route_table_id = module.vpc.vpc_default_route_table_id
  eks_cidr_block_primary     = var.eks_cidr_block_primary
  eks_cidr_block_secondary   = var.eks_cidr_block_secondary
}

# Install Helm releases workload to EKS cluster
module "helm" {
  source = "./modules/helm"
}
