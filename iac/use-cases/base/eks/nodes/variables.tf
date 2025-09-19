variable "eks_version" {
  type          = string
  default       = "1.31"
  description   = "EKS Version (default: 1.31)."
}

variable "instance_types" {
  type          = list(string)
  default       = ["t3.large"]
  description   = "instance_types"
}

variable "aws_profile" {
  type          = string
  description   = "AWS credentials profile."
}

variable "aws_region" {
  type          = string
  description   = "AWS region."
}