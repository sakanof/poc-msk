terraform {
  required_providers {
    kafka = {
      source  = "Mongey/kafka"
      version = "~> 0.7"
    }
  }
}

provider "kafka" {
  bootstrap_servers = var.bootstrap_servers

  # Authentication (set depending on your MSK setup)
  tls_enabled    = var.tls_enabled
  sasl_username  = var.sasl_username
  sasl_password  = var.sasl_password
  sasl_mechanism = var.sasl_mechanism
}

resource "kafka_topic" "this" {
  for_each          = { for t in var.topics : t.name => t }
  name              = each.value.name
  partitions        = each.value.partitions
  replication_factor = each.value.replication_factor

  config = lookup(each.value, "config", {})
}

