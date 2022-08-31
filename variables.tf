# Global vars
variable "region" {
  description = "AWS region"
  type        = string
  default     = "eu-west-2"
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
variable "eks_cidr_block_primary" {
  description = "EKS primary network in CIDR notation"
  type        = string
  default     = "10.0.1.0/24"
}

variable "eks_cidr_block_secondary" {
  description = "EKS secondary network in CIDR notation"
  type        = string
  default     = "10.0.2.0/24"
}
