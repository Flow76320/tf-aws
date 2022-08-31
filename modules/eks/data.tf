data "aws_availability_zones" "available" {
  state = "available"
}

data "aws_iam_policy" "eks_iam_policy" {
  name = "AmazonEKSClusterPolicy"
}
