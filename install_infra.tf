module "eks" {
  source = "./modules/eks"

  # region       = "eu-frankfurt-1"
  # tenancy_ocid = var.tenancy_ocid
  # user_ocid    = var.user_ocid
  # fingerprint  = var.fingerprint
}

# module "helm" {
#   source = "./modules/helm"
# }