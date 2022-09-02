variable "eks_vpc_id" {
  description = "EKS VPC ID where EKS subnets will be created"
  type        = string
}

variable "vpc_default_route_table_id" {
  description = "Default route table ID for the input VPC"
  type        = string
}

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
