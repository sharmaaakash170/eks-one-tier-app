variable "aws_region" {
  type = string
}

variable "project_name" {
  type = string
}

variable "availability_zone" {
  type = list(string)
}

variable "instance_type" {
  type = list(string)
}

variable "github_repo_url" {
  type = string
}

variable "github_owner" {
  type = string
}

variable "github_branch" {
  type = string
}

variable "github_oauth_token" {
  type = string
}

