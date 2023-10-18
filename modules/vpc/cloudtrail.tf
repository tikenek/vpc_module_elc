locals {
  s3_key_prefix = "cloudtrail-logs"
}

data "aws_s3_bucket" "s3_bucket" {
  bucket = var.s3_bucket_name
}

resource "aws_cloudwatch_log_group" "cloudtrail" {
  name = "${var.prefix}-${var.application}-cloudwatch-cloudtrail"
  tags = var.tags
}

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    sid    = "AWSCloudTrailAclCheck"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions   = ["s3:GetBucketAcl"]
    resources = [data.aws_s3_bucket.s3_bucket.arn]
  }

  statement {
    sid    = "AWSCloudTrailWrite"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    actions = [
      "s3:PutObject",
      "s3:GetObject"
    ]
    resources = ["${data.aws_s3_bucket.s3_bucket.arn}/${local.s3_key_prefix}/*"]
  }
}

resource "aws_s3_bucket_policy" "s3_bucket_policy" {
  bucket = data.aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.s3_bucket.json
}

# Create a role for CloudTrail that enables it to send events to the CloudWatch Logs log group
resource "aws_iam_role" "cloudtrail_role" {
  name = "${var.prefix}-${var.application}-cloudtrail-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
      }
    ]
  })

  tags = var.tags
}

# Assign permissions to the CloudTrail role
data "aws_iam_policy_document" "cloudtrail_policy" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]

    resources = [
      "arn:aws:logs:*:*:*"
    ]
  }
}

resource "aws_iam_policy" "cloudtrail_policy" {
  name   = "${var.prefix}-${var.application}-cloudtrail-policy"
  policy = data.aws_iam_policy_document.cloudtrail_policy.json
}

resource "aws_iam_policy_attachment" "cloudtrail" {
  name       = "${var.prefix}-${var.application}-flow-iam-policy-cloudtrail"
  policy_arn = aws_iam_policy.cloudtrail_policy.arn
  roles      = [aws_iam_role.cloudtrail_role.name]
}

# Create the trail
resource "aws_cloudtrail" "cloudtrail" {
  name                          = "${var.prefix}-${var.application}-cloudtrail"
  s3_bucket_name                = var.s3_bucket_name
  s3_key_prefix                 = local.s3_key_prefix
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true
  enable_log_file_validation    = true
  cloud_watch_logs_group_arn    = "${aws_cloudwatch_log_group.cloudtrail.arn}:*"
  cloud_watch_logs_role_arn     = aws_iam_role.cloudtrail_role.arn
  tags                          = var.tags
  depends_on                    = [aws_iam_policy_attachment.cloudtrail]
}
