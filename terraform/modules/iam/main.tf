# Cluster Role
resource "aws_iam_role" "eks_cluster" {
  name = "${var.project_name}-eks-cluster-role"
  assume_role_policy = file("${path.module}/roles/eks_cluster_role.json")
}
resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  role       = aws_iam_role.eks_cluster.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# Node
resource "aws_iam_role" "eks_iam_node_role" {
    name = "${var.project_name}-eks-node-role"
    assume_role_policy = file("${path.module}/roles/eks_node_role.json")
    tags = {
      Name = "${var.project_name}-eks-node-role"
    }
}
resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role =  aws_iam_role.eks_iam_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}
resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role = aws_iam_role.eks_iam_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role = aws_iam_role.eks_iam_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Codepipeline
resource "aws_iam_role" "codepipeline_role" {
  name = "${var.project_name}-codepipeline-role"
  assume_role_policy = file("${path.module}/roles/codepipeline_role.json")
  tags = {
    Name = "${var.project_name}-codepipeline-role"
  }
}
resource "aws_iam_role_policy_attachment" "codepipeline_full_access" {
  role = aws_iam_role.codepipeline_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodePipelineFullAccess"
}

# Codebuild
resource "aws_iam_role" "codebuild_role" {
  name = "${var.project_name}-codebuild-role"
  assume_role_policy = file("${path.module}/roles/codebuild_role.json")
  tags = {
    Name = "${var.project_name}-codebuild-role"
  }
}
resource "aws_iam_role_policy_attachment" "codebuild_full_access" {
  role = aws_iam_role.codebuild_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeBuildDeveloperAccess"
}

# Codedeploy
resource "aws_iam_role" "codedeploy_role" {
  name = "${var.project_name}-codedeploy-role"
  assume_role_policy = file("${path.module}/roles/codedeploy_role.json")
  tags = {
    Name = "${var.project_name}-codedeploy-role"
  }
}
resource "aws_iam_role_policy_attachment" "codedeploy_full_access" {
  role = aws_iam_role.codedeploy_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}
