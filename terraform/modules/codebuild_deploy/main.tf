resource "aws_codebuild_project" "eks_codebuild" {
  name = "${var.project_name}-deploy"
  service_role = var.codebuild_role_arn
  build_timeout = 10

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:6.0"
    type = "LINUX_CONTAINER"
    privileged_mode = true

    environment_variable {
      name = "CLUSTER_NAME"
      value = var.cluster_name 
    }
    
    environment_variable {
      name = "KUBECONFIG_PATH"
      value = "/root/.kube/config"
    }
  }
  
  source {
    type = "CODEPIPELINE"
    buildspec = "buildspec-deploy.yml"
  }
  
  tags = {
    Name = "${var.project_name}-deploy"
    Environment = "dev"
  }
}