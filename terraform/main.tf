module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  aws_region = var.aws_region
  availability_zone = var.availability_zone
}

module "iam" {
  source = "./modules/iam"
  project_name = var.project_name
}

module "ecr" {
  source = "./modules/ecr"
  project_name = var.project_name
}

module "s3" {
  source = "./modules/s3"
  project_name = var.project_name
}

module "codebuild" {
  source = "./modules/codebuild"
  project_name = var.project_name
  codebuild_role_arn = module.iam.codebuild_role_arn
  github_repo_url = var.github_repo_url
  ecr_repo_url = module.ecr.ecr_repo_url
}

module "eks" {
  source = "./modules/eks"
  project_name = var.project_name
  private_subnet_ids = module.vpc.private_subnets
  eks_cluster_role_arn = module.iam.eks_node_role_arn
  eks_node_role_arn = module.iam.eks_node_role_arn
  instance_types = var.instance_type
}

module "codebuild_deploy" {
  source = "./modules/codebuild_deploy"
  project_name = var.project_name
  codebuild_role_arn = module.iam.codebuild_role_arn
  cluster_name = module.eks.cluster_name
}

module "codepipeline" {
  source = "./modules/codepipeline"
  project_name = var.project_name
  codepipeline_role_arn = module.iam.codepipeline_role_arn
  s3_bucket = module.s3.bucket_name
  github_owner = var.github_owner
  github_branch = var.github_branch
  github_oauth_token = var.github_oauth_token
  github_repo = var.github_repo_url
  codebuild_project_name = module.codebuild.codebuild_project_name
  codebuild_deploy_project_name = module.codebuild_deploy.codebuild_project_name
}



