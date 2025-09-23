variable "instance_type" {
  type          = string
  default       = "t2.micro"
  description   = "EC2 Tnstance Type (default: t2.micro)"
}

variable "aws_region" {
  type          = string
  description   = "AWS Region."
}

variable "role_arn" {
  type          = string
  description   = "Role ARN."
}

variable "role_name" {
  type          = string
  description   = "Role Name."
}

variable "subnet_id" {
  type          = string
  description   = "Subnet ID."
}

variable "key_name" {
  type          = string
  description   = "Keypair Name."
}

variable "security_groups" {
  type          = list(string)
  description   = "Security Group List."
}

variable "bootstrap_server" {
  type          = string
  description   = "Bootstrap Server for SASL IAM Authentication."
}

variable "topic_name" {
  type          = string
  description   = "Name of the topic."
}

variable "group_name" {
  type          = string
  description   = "Name of the topic."
}

variable "client_type" {
  type          = string
  description   = "Client Type (`topic-owner`, `producer`, `consumer` and `monitoring`)."
}

variable "tag_name" {
  type          = string
  description   = "Tag Name."
}