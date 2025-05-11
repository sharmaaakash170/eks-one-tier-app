variable "project_name" {
  type = string
}

variable "codepipeline_role_arn" {
  type = string
}

variable "s3_bucket" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_repo" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "github_oauth_token" {
  type = string
}

variable "codebuild_project_name" {
  type = string
}

variable "codebuild_deploy_project_name" {
  type = string
}