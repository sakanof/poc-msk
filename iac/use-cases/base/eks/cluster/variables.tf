variable "eks_version" {
  type          = string
  default       = "1.31"
  description   = "EKS Version (default: 1.31)."
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