resource "aws_cloudwatch_log_group" "flow_logs" {
  name = "${var.prefix}-${var.application}-cloudwatch-flow-logs"
  tags = var.tags
}



resource "aws_iam_role" "flow_logs" {
  name = "${var.prefix}-${var.application}-flow-logs-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
      }
    ]
  })
}

data "aws_iam_policy_document" "flow_logs_iam" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogGroups",
      "logs:DescribeLogStreams",
    ]

    resources = ["*"]
  }
}

resource "aws_iam_policy" "flowlogs_policy" {
  name   = "${var.prefix}-${var.application}-flow-logs-policy"
  policy = data.aws_iam_policy_document.flow_logs_iam.json
}


resource "aws_iam_policy_attachment" "flow_logs" {
  name       = "${var.prefix}-${var.application}-flow-iam-policy-flows-logs"
  policy_arn = aws_iam_policy.flowlogs_policy.arn
  roles      = [aws_iam_role.flow_logs.name]
}


resource "aws_flow_log" "vpc" {
  iam_role_arn    = aws_iam_role.flow_logs.arn
  traffic_type    = "ALL"
  log_destination = aws_cloudwatch_log_group.flow_logs.arn
  vpc_id          = aws_vpc.main.id
  tags            = var.tags
}


# # #Security Group 
# # resource "aws_security_group" "vpc_task" {
# #   name        = "vpc_task"
# #   description = "Allow TLS inbound traffic"

# #   ingress {
# #     description = "Allow ssh"
# #     from_port   = 22
# #     to_port     = 22
# #     protocol    = "tcp"
# #     cidr_blocks = ["73.143.65.89/32"]
# #   }

# #cidr block in sec group can be also declared as a variable
# #only if we will use vpn we can used cidr blocks written as a hardcodded cidr blocks

# #   egress {
# #     from_port   = 0
# #     to_port     = 0
# #     protocol    = "-1"
# #     cidr_blocks = ["0.0.0.0/0"]
# #   }

# # }
