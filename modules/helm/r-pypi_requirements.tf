# Create requirements of Pypi server Helm chart
### Namespace
resource "kubernetes_namespace" "pypi_server_namespace" {
  metadata {
    name = var.pypi_server_namespace
  }
}

### Authentication credentials
resource "random_password" "pypi_password" {
  length           = 20
  special          = true
  override_special = "_%@"
}

resource "random_password" "salt" {
  length = 8
}

resource "htpasswd_password" "hash_pypi_password" {
  password = random_password.pypi_password.result
  salt     = random_password.salt.result
}

resource "kubernetes_secret" "pypi_auth" {
  metadata {
    name      = "pypi-auth"
    namespace = kubernetes_namespace.pypi_server_namespace.metadata[0].name
  }

  data = {
    ".htpasswd" = "${var.pypi_username}:${htpasswd_password.hash_pypi_password.apr1}"
  }

  type = "Opaque"
}
