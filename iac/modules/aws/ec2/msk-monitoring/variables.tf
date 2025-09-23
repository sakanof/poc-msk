variable "instance_type" {
  type          = string
  default       = "t2.micro"
  description   = "EC2 Tnstance Type (default: t2.micro)"
}

variable "aws_region" {
  type          = string
  description   = "AWS Region."
}

variable "role_name" {
  type          = string
  description   = "Role Name."
}

variable "role_arn" {
  type          = string
  description   = "Role ARN."
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
