terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.47"
}

locals {
  environment = "prod"
}

resource "aws_s3_bucket" "prod" {
  bucket = "hello-cloud-prod"

  tags = {
    Name        = local.environment
    Environment = local.environment
  }
}

resource "aws_s3_bucket_policy" "public" {
  bucket = aws_s3_bucket.prod.id

  policy = templatefile("../common/policy/public_bucket.json.tpl", {
    bucket_arn = aws_s3_bucket.prod.arn
  })
}

