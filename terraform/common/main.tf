terraform {
  required_version = ">= 0.12"
}

provider "aws" {
  region  = "eu-north-1"
  version = "~> 2.47"
}

resource "aws_s3_bucket" "assets" {
  bucket = "hello-cloud-assets"

  tags = {
    Name = "assets"
  }
}
resource "aws_s3_bucket_policy" "public_policy" {
  bucket = aws_s3_bucket.assets.id

  policy = templatefile("policy/public_bucket.json.tpl", {
    bucket_arn = aws_s3_bucket.assets.arn
  })
}
