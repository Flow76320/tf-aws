output "region" {
  description = "Input AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.eks_cluster.id
}

output "cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.eks_cluster.arn
}

output "cluster_endpoint" {
  description = "Endpoint for EKS control plane"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "eks_kubeconfig_certificate_authority_data" {
  description = "EKS certificate authority data"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}

output "dns_domain" {
  description = "DNS domain configured for External-DNS"
  value       = aws_route53_zone.dns_zone.name
}
