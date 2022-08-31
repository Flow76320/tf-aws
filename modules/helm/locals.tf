locals {
  pypi_values = {
    ingress_class_name = kubernetes_ingress_class.eks_alb.metadata[0].name
  }
}
