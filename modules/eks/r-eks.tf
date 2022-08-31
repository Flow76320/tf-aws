# Create IAM role to allow IAM user to manager AWS API
resource "aws_iam_role" "eks_iam_role" {
  name = "eks-cluster-manager"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.tags
}

# Attach EKS defined policy to the previous role
resource "aws_iam_role_policy_attachment" "eks_iam_role_policy_attachment" {
  role       = aws_iam_role.eks_iam_role.name
  policy_arn = data.aws_iam_policy.eks_iam_policy.arn
}

# Create AKS cluster
resource "aws_eks_cluster" "eks_cluster" {
  name     = local.cluster_name
  role_arn = aws_iam_role.eks_iam_role.arn

  vpc_config {
    subnet_ids              = [aws_subnet.eks_subnet_primary.id, aws_subnet.eks_subnet_secondary.id]
    endpoint_public_access  = var.endpoint_public_access
    endpoint_private_access = var.endpoint_private_access
  }

  tags = local.tags

  depends_on = [
    aws_iam_role_policy_attachment.eks_iam_role_policy_attachment,
  ]
}
