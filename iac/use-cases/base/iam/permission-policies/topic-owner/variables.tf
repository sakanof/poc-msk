variable "aws_account" {
  type          = string
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

variable "topic_name" {
  type          = string
  default       = "*"
  description   = "Name of the Kafka topic (default: *)."
}