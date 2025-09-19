output "arn" {
  value = aws_msk_cluster.msk_cluster.arn
}

output "cluster_uuid" {
  value = aws_msk_cluster.msk_cluster.cluster_uuid
}

output "cluster_name" {
  value = var.cluster_name
}

output "bootstrap_brokers" {
  value = aws_msk_cluster.msk_cluster.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl_iam" {
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_iam
}

output "bootstrap_brokers_sasl_scram" {
  value       = aws_msk_cluster.msk_cluster.bootstrap_brokers_sasl_scram
}

output "zookeeper_connect_string" {
  value = aws_msk_cluster.msk_cluster.zookeeper_connect_string
}
