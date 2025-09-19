output "arn" {
  value = module.msk_cluster.arn
}

output "cluster_uuid" {
  value = module.msk_cluster.cluster_uuid
}

output "cluster_name" {
  value = var.project_name
}

output "bootstrap_brokers" {
  value = module.msk_cluster.bootstrap_brokers
}

output "bootstrap_brokers_tls" {
  value       = module.msk_cluster.bootstrap_brokers_tls
}

output "bootstrap_brokers_sasl_iam" {
  value       = module.msk_cluster.bootstrap_brokers_sasl_iam
}

output "bootstrap_brokers_sasl_scram" {
  value       = module.msk_cluster.bootstrap_brokers_sasl_scram
}

output "zookeeper_connect_string" {
  value = module.msk_cluster.zookeeper_connect_string
}