locals {
  pypi_values = {
    basic_auth_secret_name = kubernetes_secret.pypi_auth.metadata[0].name
  }
}
