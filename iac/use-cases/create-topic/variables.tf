variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "msk_cluster_name" {
  description = "Name of the MSK cluster"
  type        = string
}

variable "topic_name" {
  description = "Name of the Kafka topic to create"
  type        = string
}

variable "topic_partitions" {
  description = "Number of partitions for the topic"
  type        = number
  default     = 3
}

variable "topic_replication_factor" {
  description = "Replication factor for the topic"
  type        = number
  default     = 3
}

variable "topic_config" {
  description = "Topic configuration parameters"
  type        = map(string)

  default = {
    "cleanup.policy"    = "delete"
    "retention.ms"      = "604800000"  # 7 days
    "segment.ms"        = "86400000"    # 1 day
    "compression.type"  = "producer"
  }
}
