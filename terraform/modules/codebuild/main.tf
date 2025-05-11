resource "aws_codebuild_project" "codebuild" {
  name = "${var.project_name}-codebuild"
  description = "Build and pushes Docker image to ECR"
  service_role = var.codebuild_role_arn
  build_timeout = 5

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image = "aws/codebuild/standard:7.0"
    type = "LINUX_CONTAINER"
    privileged_mode = true
    environment_variable {
        name = "REPOSITORY_URI"
        value = var.ecr_repo_url
    }
  }

  source {
    type = "GITHUB"
    location = var.github_repo_url
    buildspec = "buildspec.yaml"
  }
  artifacts {
    type = "NO_ARTIFACTS"
  }
}