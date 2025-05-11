resource "aws_s3_bucket" "s3" {
  bucket = "${var.project_name}-codepipeline-artifacts"
  force_destroy = true

  tags = {
    Name = "${var.project_name}-artifacts"
    Environment = "dev"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse" {
  bucket = aws_s3_bucket.s3.id
  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}