variable "eks_vpc_id" {
  description = "EKS VPC ID where EKS subnets will be created"
  type        = string
}

variable "eks_cidr_block" {
  description = "EKS network in CIDR notation"
  type        = string
  default     = "10.0.1.0/24"
}
