variable "aws_region" {
  type          = string
  default       = "us-east-1"
  description   = "AWS region where the MSK cluster and EC2 exist."
}

variable "aws_account" {
  type          = string
  default       = "891377173254"
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

variable "transaction_id" {
  type          = string
  default       = "*"
  description   = "Transaction ID (default: *)."
}
