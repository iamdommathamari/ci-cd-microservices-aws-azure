# eks-cluster.tf
resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = aws_subnet.eks_subnets[*].id
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Environment = "dev"
    Name        = var.cluster_name
  }
}

resource "aws_eks_node_group" "eks_nodes" {
  cluster_name    = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.cluster_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = aws_subnet.eks_subnets[*].id
  instance_types  = [var.node_instance_type]
  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.desired_capacity + 1
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_worker_policy
  ]

  tags = {
    Name = "${var.cluster_name}-node-group"
  }
}
