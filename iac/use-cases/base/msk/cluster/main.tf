module "msk_cluster" {
  source                            = "../../../../modules/aws/msk/cluster"

  cluster_name                      = var.project_name

  cluster_config_arn                = data.terraform_remote_state.cluster_config.outputs.arn
  cluster_config_latest_revision    = data.terraform_remote_state.cluster_config.outputs.latest_revision

  number_of_broker_nodes            = 2
  client_subnets                    = [
    data.terraform_remote_state.vpc.outputs.private_subnet_az1_id,
    data.terraform_remote_state.vpc.outputs.private_subnet_az2_id
  ]
  # data.terraform_remote_state.vpc.outputs.private_subnets

  instance_type                     = "kafka.t3.small"  # $0.0456/hour
  # instance_type                   = "kafka.m5.large" # $0.21/hour - Needed for Mult VPC Connection

  security_groups   = [
    data.terraform_remote_state.msk_sg.outputs.id,
  ]
}
