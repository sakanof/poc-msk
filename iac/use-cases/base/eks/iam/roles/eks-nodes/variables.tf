variable "aws_account" {
  type          = string
  default       = "891377173254"
  description   = "AWS Account ID (12-digit)."
}

variable "aws_profile" {
  type          = string
  description   = "AWS credentials profile."
}

variable "aws_region" {
  type          = string
  description   = "AWS region."
}

variable "eks_cluster_name" {
  type          = string
  default       = "poc-aws-msk"
  description   = "EKS Cluster Name."
}