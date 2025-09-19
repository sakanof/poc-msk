variable "name" {
  type        = string
  description = "Name for the config."
}

variable "kafka_version" {
  type        = string
  default     = "3.6.0"
  description = "Kafka Version (default: 3.6.0)."
}
