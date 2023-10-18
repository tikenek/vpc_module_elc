terraform {
  backend "s3" {
    bucket         = "terraform-state-files-4pzo4tch"
    key            = "aws-vpc-tynar"
    region         = "us-east-1"
    dynamodb_table = "terraform-state-files-4pzo4tch"
  }
}
