# Create requirements of Helm charts
## Pypi server
### External access
resource "kubernetes_ingress_class" "eks_alb" {
  metadata {
    name = "eks-alb"
  }

  spec {
    controller = "ingress.k8s.aws/alb"
    # parameters {
    #   apiGroup = elbv2.k8s.aws
    #   kind     = IngressClassParams
    #   name     = eks_alb_cfg
    # }
  }
}

### Authentication
resource "random_password" "pypi_password" {
  length           = 20
  special          = true
  override_special = "_@"
}

resource "kubernetes_secret" "pypi_auth" {
  metadata {
    name = "pypi-auth"
  }

  data = {
    ".htpasswd" : jsonencode(
      "${var.pypi_username}:${random_password.pypi_password.result}"
    )
  }

  type = "Opaque"
}
