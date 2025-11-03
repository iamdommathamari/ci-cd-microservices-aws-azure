# outputs.tf
output "cluster_name" {
  description = "EKS Cluster Name"
  value       = aws_eks_cluster.eks_cluster.name
}

output "cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "node_role_arn" {
  description = "Node IAM Role ARN"
  value       = aws_iam_role.eks_node_role.arn
}

output "vpc_id" {
  description = "VPC ID"
  value       = aws_vpc.eks_vpc.id
}
