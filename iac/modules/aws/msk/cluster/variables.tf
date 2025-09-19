variable "kafka_version" {
  type        = string
  default     = "3.6.0"
  description = "Kafka Version (default: 3.6.0)."
}

variable "cluster_name" {
  type        = string
  description = "Name of the MSK Cluster."
}

variable "cluster_config_arn" {
  type        = string
  description = "ARN of the cluster config."
}

variable "cluster_config_latest_revision" {
  type        = string
  description = "Latest revision of the cluster config."
}

variable "instance_type" {
  type        = string
  default     = "kafka.m5.large"
  description = "Instance Type (default: kafka.m5.large)."
}

variable "number_of_broker_nodes" {
  type        = number
  default     = 3
  description = "Number of Broker Nodes (default: 3)."
}

variable "client_subnets" {
  type        = list(string)
  description = "List of client subnets."
}

variable "security_groups" {
  type        = list(string)
  description = "List of Security Groups."
}

variable "enable_mult_vpc_connection" {
  type        = bool
  default     = false
  description = "Enable multiple VPC connections (default: false)."
}
