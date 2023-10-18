variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "region" {
  description = "Region for the VPC"
  type        = string
  default     = "us-east-1"
}

variable "public_subnets_cidr" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = ""
  type        = list(string)
}

variable "public_subnets" {
  description = ""
  type        = list(string)
}

variable "availability_zones" {
  description = "Availability zones to use for subnets"
  type        = list(string)
}

variable "tags" {
  description = "This is the name of the resources"
  type        = map(string)
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket for storing all CloudTrail logs"
  type        = string
}

variable "prefix" {
  description = ""
  type        = string
}

variable "application" {
  description = ""
  type        = string
}
