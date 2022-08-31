resource "helm_release" "pypi_server" {
  name       = "pypi"
  repository = "https://owkin.github.io/charts" # ;-)
  chart      = "owkin/pypiserver"
  version    = "3.1.1"

  namespace         = var.pypi_server_namespace
  dependency_update = true
  create_namespace  = true
  timeout           = 300

  values = [
    "${templatefile("${path.module}/pypi_values.yaml",
    local.pypi_values)}"
  ]
}
