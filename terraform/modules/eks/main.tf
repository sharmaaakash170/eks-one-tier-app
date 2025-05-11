resource "aws_eks_cluster" "eks_cluster" {
  name = "${var.project_name}-eks-cluster"
  role_arn = var.eks_cluster_role_arn

  vpc_config {
    subnet_ids = var.private_subnet_ids
  }

  depends_on = [ var.eks_cluster_role_arn ]
}

resource "aws_eks_node_group" "eks_node_group" {
  cluster_name = aws_eks_cluster.eks_cluster.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn = var.eks_node_role_arn
  subnet_ids = var.private_subnet_ids

  scaling_config {
    desired_size = 2
    max_size = 4
    min_size = 1
  }

  instance_types = var.instance_types

  depends_on = [ aws_eks_cluster.eks_cluster ]
}