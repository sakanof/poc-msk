variable "aws_region" {
  type          = string
  default       = "us-east-1"
  description   = "AWS region (default: us-east-1)."
}

variable "aws_account" {
  type          = string
  description   = "AWS Account ID (12-digit)."
}

variable "cluster_uuid" {
  type          = string
  description   = "UUID of the MSK cluster."
}

variable "cluster_name" {
  type          = string
  description   = "Name of the MSK cluster."
}

variable "topic_name" {
  type          = string
  default       = "*"
  description   = "Group Name (default: *)."
}

variable "group_name" {
  type          = string
  description   = "Group Name (default: *)."
}
