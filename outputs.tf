# Pypi outputs
output "pypi_server_username" {
  description = "Pypi server username"
  value       = module.helm.pypi_server_username
}

output "pypi_server_password" {
  description = "Pypi server password"
  value       = module.helm.pypi_server_password
  sensitive   = true
}

