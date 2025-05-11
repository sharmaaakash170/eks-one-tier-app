resource "aws_codepipeline" "codepipeline" {
  name = "${var.project_name}-codepipeline"
  role_arn = var.codepipeline_role_arn

  artifact_store {
    location = var.s3_bucket
    type = "S3"
  }

  stage {
    name = "Source"
    action {
      name = "Source"
      category = "Source"
      owner = "ThirdParty"
      provider = "GitHub"
      version = "2"
      output_artifacts = [ "source_output" ]

      configuration = {
        Owner = var.github_owner
        Repo = var.github_repo 
        Branch = var.github_branch
        OAuthToken = var.github_oauth_token
      }
    }
  }

  stage {
    name = "Build"
    action {
      name = "CodeBuild"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = [ "source_output" ]
      output_artifacts = [ "build_output" ]

      configuration = {
        ProjectName = var.codebuild_project_name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name = "DeployToEKS"
      category = "Build"
      owner = "AWS"
      provider = "CodeBuild"
      version = "1"
      input_artifacts = ["build_output"]
      configuration = {
        ProjectName = var.codebuild_deploy_project_name
      }
    }
  }
}