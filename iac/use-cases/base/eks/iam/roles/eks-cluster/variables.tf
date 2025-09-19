variable "aws_account" {
  type          = string
  description   = "AWS Account ID (12-digit)."
}

variable "eks_cluster_name" {
  type          = string
  default       = "poc-aws-msk"
  description   = "EKS Cluster Name."
}

variable "aws_profile" {
  type          = string
  description   = "AWS credentials profile."
}

variable "aws_region" {
  type          = string
  description   = "AWS region."
}