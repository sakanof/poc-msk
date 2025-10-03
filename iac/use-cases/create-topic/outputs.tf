output "topic_name" {
  description = "Name of the created topic"
  value       = kafka_topic.topic.name
}

output "topic_partitions" {
  description = "Number of partitions"
  value       = kafka_topic.topic.partitions
}

output "topic_replication_factor" {
  description = "Replication factor"
  value       = kafka_topic.topic.replication_factor
}

output "msk_cluster_arn" {
  description = "ARN of the MSK cluster"
  value       = data.aws_msk_cluster.cluster.arn
}

output "bootstrap_brokers_tls" {
  description = "TLS bootstrap brokers"
  value       = data.aws_msk_cluster.cluster.bootstrap_brokers_tls
  sensitive   = true
}
