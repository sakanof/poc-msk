variable "aws_account" {
  type        = string
  description = "AWS Account ID (12-digit)."
}

variable "aws_region" {
  type        = string
  description = "AWS region."
}

variable "cluster_name" {
  type        = string
  description = "Name of the EKS cluster."
}