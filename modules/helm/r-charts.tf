resource "helm_release" "pypi_server" {
  name       = "pypi"
  repository = "https://owkin.github.io/charts" # ;-)
  chart      = "pypiserver"
  version    = "3.1.1"

  namespace         = kubernetes_namespace.pypi_server_namespace.metadata[0].name
  dependency_update = true
  create_namespace  = true
  timeout           = 300

  values = [
    "${templatefile("${path.module}/pypi_values.yaml",
    local.pypi_values)}"
  ]
}

resource "helm_release" "mlhub" {
  name  = "mlhub"
  chart = "${path.module}/ml-hub-master/mlhub-1.1.0.tgz" # Locally built

  namespace         = kubernetes_namespace.mlhub_namespace.metadata[0].name
  dependency_update = true
  create_namespace  = true
  timeout           = 300

  values = [
    "${templatefile("${path.module}/mlhub_values.yaml",
    local.mlhub_values)}"
  ]
}
