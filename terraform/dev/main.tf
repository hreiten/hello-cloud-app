terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.47"
}

locals {
  environment = "dev"
}

resource "aws_s3_bucket" "dev" {
  bucket = "hello-cloud-dev"

  tags = {
    Name        = local.environment
    Environment = local.environment
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.dev.id

  policy = templatefile("../common/policy/public_bucket.json.tpl", {
    bucket_arn = aws_s3_bucket.dev.arn
  })
}

