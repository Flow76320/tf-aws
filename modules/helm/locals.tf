locals {
  # Override Helm values of Charts
  pypi_values = {
    basic_auth_secret_name = kubernetes_secret.pypi_auth.metadata[0].name
    dns_domain             = var.dns_domain
  }
  mlhub_values = {
    dns_domain = var.dns_domain
  }
}
