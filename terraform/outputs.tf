output "eks_cluster_name" {
  description = "EKS cluster name"
  value       = aws_eks_cluster.wanderlust.name
}

output "eks_cluster_endpoint" {
  description = "EKS Kubernetes API endpoint"
  value       = aws_eks_cluster.wanderlust.endpoint
}

output "eks_cluster_arn" {
  description = "EKS cluster ARN"
  value       = aws_eks_cluster.wanderlust.arn
}

output "eks_node_group_name" {
  description = "EKS managed node group name"
  value       = aws_eks_node_group.wanderlust.node_group_name
}

output "eks_subnet_ids" {
  description = "Subnets used by the EKS cluster and node group"
  value       = data.aws_subnets.eks.ids
}
