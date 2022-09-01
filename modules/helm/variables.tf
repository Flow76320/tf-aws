variable "dns_domain" {
  description = "DNS domain to register all required entries"
  type        = string
  default     = "test.test"
}

variable "pypi_server_namespace" {
  description = "Pypi server namespace"
  type        = string
  default     = "pypi"
}

variable "pypi_username" {
  description = "Pypi server username for basic auth"
  type        = string
  default     = "pypi"
}

variable "mlhub_namespace" {
  description = "MLHub namespace"
  type        = string
  default     = "mlhub"
}
