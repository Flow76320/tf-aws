# Global vars
variable "region" {
  
}

variable "tags" {
  type        = map(string)
  description = "Map of tags to set to resources"
  default     = {}
}

# VPC vars
variable "vpc_cidr_block" {
  description = "VPC network in CIDR notation"
  default     = "10.0.0.0/16"
}

# EKS vars
variable "eks_cidr_block" {
  description = "EKS network in CIDR notation"
  type        = string
  default     = "10.0.1.0/24"
}
