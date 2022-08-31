# Create IAM role to allow IAM user to manage EC2 API
resource "aws_iam_role" "eks_iam_role_workers" {
  name = "eks-workers"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = local.tags
}

# Attach EKS defined policy to the previous role
resource "aws_iam_role_policy_attachment" "eks_iam_role_policy_attachments_workers" {
  for_each = data.aws_iam_policy.eks_iam_policy_workers

  role       = aws_iam_role.eks_iam_role_workers.name
  policy_arn = each.value.arn
}

# Create AKS workers
resource "aws_eks_node_group" "eks_nodes" {
  # TODO Can be improved with for_each & map to create several node groups (per workload type, or service for example)
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "workload"
  node_role_arn   = aws_iam_role.eks_iam_role_workers.arn
  subnet_ids      = [aws_subnet.eks_subnet_primary.id, aws_subnet.eks_subnet_secondary.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_iam_role_policy_attachments_workers
  ]
}
