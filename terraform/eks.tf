data "aws_subnets" "eks" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

resource "aws_eks_cluster" "wanderlust" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.eks_kubernetes_version

  vpc_config {
    subnet_ids              = data.aws_subnets.eks.ids
    endpoint_private_access = false
    endpoint_public_access  = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy
  ]

  tags = {
    Name        = var.eks_cluster_name
    Project     = "Wanderlust"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}

resource "aws_eks_node_group" "wanderlust" {
  cluster_name    = aws_eks_cluster.wanderlust.name
  node_group_name = var.eks_node_group_name
  node_role_arn   = aws_iam_role.eks_node.arn
  subnet_ids      = data.aws_subnets.eks.ids

  ami_type       = "AL2023_x86_64_STANDARD"
  capacity_type  = "ON_DEMAND"
  instance_types = [var.eks_node_instance_type]
  disk_size      = 30

  scaling_config {
    desired_size = var.eks_desired_nodes
    min_size     = var.eks_min_nodes
    max_size     = var.eks_max_nodes
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_worker,
    aws_iam_role_policy_attachment.eks_node_ecr,
    aws_iam_role_policy_attachment.eks_node_cni
  ]

  tags = {
    Name        = var.eks_node_group_name
    Project     = "Wanderlust"
    ManagedBy   = "Terraform"
    Environment = "dev"
  }
}
