# Resource to retrieve its content as base64
data "local_file" "mlhub_archive" {
  filename = "${path.module}/mlhub.zip"

  depends_on = [
    null_resource.download_archive
  ]
}
