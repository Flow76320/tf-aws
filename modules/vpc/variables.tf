variable "tags" {
  type        = map(string)
  description = "Map of tags to set to resources"
  default     = {}
}

variable "vpc_cidr_block" {
  description = "VPC network in CIDR notation"
  default     = "10.0.0.0/16"
}

variable "instance_tenancy" {
  description = "Tenancy option for instances launched into the VPC to ensure they are run either on EC2 tenancy or a dedicated one"
  default     = "default"

  validation {
    condition     = contains(["default", "dedicated"], var.instance_tenancy)
    error_message = "Variable instance_tenancy must be default or dedicated."
  }
}

variable "enable_dns_support" {
  description = "A boolean flag to enable/disable DNS support in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  type        = bool
  default     = true
}
