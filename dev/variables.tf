variable "cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "region" {
  type        = string
  description = "Region for the VPC"
  default     = "us-east-1"
}

variable "public_subnets_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets_cidr" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
}

variable "private_subnets" {
  type    = list(string)
  default = ["10.0.5.0/24", "10.0.6.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.0.7.0/24", "10.0.8.0/24"]
}

variable "availability_zones" {
  description = "Availability zones to use for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  description = "This is the name of the resources"
  type        = map(string)
  default = {
    "Name" = "sandbox-tynar"
  }
}

variable "s3_bucket_name" {
  type        = string
  description = "Name of the S3 bucket for storing all CloudTrail logs"
  default     = "sandbox-vpc-tynar-s3-backend"
}

variable "prefix" {
  type        = string
  description = "The first component of the name for the resources"
  default     = "tynar"
}
variable "application" {
  type        = string
  description = "The second component of the name for the resources"
  default     = "vpc"
}

variable "vpc_id" {
  description = "Unique identifier of VPC  "
  type        = string
  default     = "vpc-123456789"
}