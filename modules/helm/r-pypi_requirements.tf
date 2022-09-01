# Create requirements of Helm charts
## Pypi server
### Namespace
resource "kubernetes_namespace" "pypi_server_namespace" {
  metadata {
    name = var.pypi_server_namespace
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
    name      = "pypi-auth"
    namespace = kubernetes_namespace.pypi_server_namespace.metadata[0].name
  }

  data = {
    ".htpasswd" : jsonencode(
      "${var.pypi_username}:${random_password.pypi_password.result}"
    )
  }

  type = "Opaque"
}
