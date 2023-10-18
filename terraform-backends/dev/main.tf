locals {
  region = "us-east-1"
}

provider "aws" {
  region = local.region
}

resource "random_string" "random" {
  length  = 8
  special = false
  upper   = false
}

# KMS
resource "aws_kms_key" "kms_key" {
  description             = "This key is used to encrypt bucket objects"
  deletion_window_in_days = 10
}

# S3
resource "aws_s3_bucket" "s3_bucket" {
  bucket = "terraform-state-files-${random_string.random.result}"
}

resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "s3_encryption" {
  bucket = aws_s3_bucket.s3_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.kms_key.arn
      sse_algorithm     = "aws:kms"
    }
  }
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.s3_bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# Dynamo
resource "aws_dynamodb_table" "dynamodb_table" {
  hash_key     = "LockID"
  name         = "terraform-state-files-${random_string.random.result}"
  billing_mode = "PAY_PER_REQUEST"
  attribute {
    name = "LockID"
    type = "S"
  }
}

output "s3_bucket" {
  value = aws_s3_bucket.s3_bucket.bucket
}

output "dynamodb_table" {
  value = aws_dynamodb_table.dynamodb_table.id
}
