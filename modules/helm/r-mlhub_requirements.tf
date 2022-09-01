# Create requirements of Helm charts
## MLHub server
### Namespace
resource "kubernetes_namespace" "mlhub_namespace" {
  metadata {
    name = var.mlhub_namespace
  }
}

resource "null_resource" "download_archive" {
  provisioner "local-exec" {
    working_dir = path.module
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      wget -O mlhub.zip https://github.com/ml-tooling/ml-hub/archive/refs/heads/master.zip
    EOT
  }

  triggers = {
    always = timestamp()
  }
}

# Project doc indicated that we need to package the Chart by ourselves. As there are fixes but no new release, let's set Chart $VERSION to 1.1.0
resource "null_resource" "mlhub_package_helm" {
  provisioner "local-exec" {
    working_dir = path.module
    interpreter = ["/bin/bash", "-c"]
    command     = <<-EOT
      rm -rf ml-hub-master ${path.module}/mlhub-1.1.0.tgz
      unzip mlhub.zip
      cd ml-hub-master
      sed -i "s/\$VERSION/1.1.0/g" helmchart/mlhub/Chart.yaml
      sed -i "s/\$VERSION/1.0.0/g" helmchart/mlhub/values.yaml
      helm package helmchart/mlhub
    EOT
  }

  triggers = {
    content = data.local_file.mlhub_archive.content_base64
  }

}
