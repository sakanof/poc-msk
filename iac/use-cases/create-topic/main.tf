# Data source to get MSK cluster information
data "aws_msk_cluster" "cluster" {
  cluster_name = var.msk_cluster_name
}

# Get the bootstrap brokers
data "aws_msk_broker_nodes" "cluster_nodes" {
  cluster_arn = data.aws_msk_cluster.cluster.arn
}

# Kafka provider configuration
provider "kafka" {
  bootstrap_servers = split(",", data.aws_msk_cluster.cluster.bootstrap_brokers_sasl_iam)

  # TLS configuration for MSK
  tls_enabled = true

  # SASL configuration for IAM authentication
  sasl_mechanism = "aws-iam"
  sasl_aws_region = var.aws_region

  # The provider will automatically use the instance's IAM role
  sasl_aws_profile = ""
}

# Create the Kafka topic
resource "kafka_topic" "topic" {
  name               = var.topic_name
  replication_factor = var.topic_replication_factor
  partitions         = var.topic_partitions

  config = var.topic_config
}
