output "region" {
  description = "Input AWS region"
  value       = var.region
}

output "cluster_name" {
  description = "Kubernetes Cluster Name"
  value       = local.cluster_name
}

# output "cluster_id" {
#   description = "EKS cluster ID"
#   # value       = .cluster_id # TODO update
# }

# output "cluster_endpoint" {
#   description = "Endpoint for EKS control plane"
#   # value       = .cluster_endpoint # TODO update
# }

# output "cluster_security_group_id" {
#   description = "Security group ids attached to the cluster control plane"
#   # value       = .cluster_security_group_id # TODO update
# }

# output "kubeconfig-certificate-authority-data" {
#   value = aws_eks_cluster.example.certificate_authority[0].data
# }
