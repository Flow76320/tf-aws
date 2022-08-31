data "aws_availability_zones" "available" {
  state = "available"
  filter {
    name   = "region-name"
    values = [var.region]
  }
}

data "aws_iam_policy" "eks_iam_policy" {
  name = "AmazonEKSClusterPolicy"
}
