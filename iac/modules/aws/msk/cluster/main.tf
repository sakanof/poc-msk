data "aws_availability_zones" "azs" {
  state = "available"
}

resource "aws_kms_key" "kms" {
  description = "Key for at res MSK encryption"
}

resource "aws_msk_cluster" "msk_cluster" {
  cluster_name           = var.cluster_name

  kafka_version          = var.kafka_version

  number_of_broker_nodes = var.number_of_broker_nodes

  broker_node_group_info {
    instance_type = var.instance_type

    client_subnets = var.client_subnets

    storage_info {
      ebs_storage_info {
        volume_size = 10
      }
    }

    security_groups = var.security_groups

    # Enable Multi-VPC Private Connection based on variable
    dynamic "connectivity_info" {
      for_each = var.enable_mult_vpc_connection ? [1] : []

      content {
      vpc_connectivity {
        client_authentication {
        sasl {
          iam = true
        }
        }
      }
      }
    }
  }

  # Attach the MSK Configuration here
  configuration_info {
    arn      = var.cluster_config_arn
    revision = var.cluster_config_latest_revision
  }

  client_authentication {
    sasl {
      iam   = true
    }

    tls {
      certificate_authority_arns = []
    }
  }

  encryption_info {
    encryption_at_rest_kms_key_arn = aws_kms_key.kms.arn
    encryption_in_transit {
      client_broker = "TLS"
      in_cluster    = true
    }
  }

  tags = {
    Name = "poc-aws-msk"
  }
}
