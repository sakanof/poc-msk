variable "bootstrap_servers" {
  description = "Kafka bootstrap servers (comma-separated host:port)"
  type        = string
}

variable "tls_enabled" {
  description = "Enable TLS for Kafka provider"
  type        = bool
  default     = true
}

variable "sasl_username" {
  description = "SASL username (for SCRAM or PLAIN). Leave empty if using IAM/Kerberos"
  type        = string
  default     = null
}

variable "sasl_password" {
  description = "SASL password (for SCRAM or PLAIN). Leave empty if using IAM/Kerberos"
  type        = string
  default     = null
  sensitive   = true
}

variable "sasl_mechanism" {
  description = "SASL mechanism (SCRAM-SHA-512, SCRAM-SHA-256, PLAIN, AWS_MSK_IAM, GSSAPI)"
  type        = string
  default     = "SCRAM-SHA-512"
}

variable "topics" {
  description = <<EOT
List of topics to create. Example:
[
  {
    name               = "orders"
    partitions         = 3
    replication_factor = 3
    config = {
      "cleanup.policy" = "delete"
      "retention.ms"   = "604800000"
    }
  },
  {
    name               = "payments"
    partitions         = 1
    replication_factor = 3
  }
]
EOT
  type = list(object({
    name               = string
    partitions         = number
    replication_factor = number
    config             = optional(map(string))
  }))
}
