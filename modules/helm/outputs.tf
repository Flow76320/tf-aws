output "pypi_server_username" {
  description = "Pypi server username"
  value       = var.pypi_username
}

output "pypi_server_password" {
  description = "Pypi server password"
  value       = random_password.pypi_password.result
}
