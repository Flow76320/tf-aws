# Get my public IP
data "http" "my_public_ip" {
  url = "http://ipv4.icanhazip.com"
}

# Get availability zones to create subnets in
data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

# Retrieve ARN of policies
data "aws_iam_policy" "eks_iam_policy_cluster" {
  for_each = toset([
    "AmazonEKSClusterPolicy",
    "AmazonEKSVPCResourceController"
  ])
  name = each.key
}

data "aws_iam_policy" "eks_iam_policy_workers" {
  for_each = toset([
    "AmazonEKSWorkerNodePolicy",
    "AmazonEKS_CNI_Policy",
    "AmazonEC2ContainerRegistryReadOnly"
  ])
  name = each.key
}
