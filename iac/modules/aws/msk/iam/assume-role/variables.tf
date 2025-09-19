variable "custom_name" {
  type        = string
  description = "Custom name for the Role"
}

variable "service_identifiers" {
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
  description = "List of service identifiers (default: [ec2.amazonaws.com])."
}
