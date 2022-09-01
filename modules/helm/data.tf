data "local_file" "mlhub_archive" {
  filename = "${path.module}/mlhub.zip"

  depends_on = [
    null_resource.download_archive
  ]
}
