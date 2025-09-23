module "ec2_instance" {
  source            = "/poc-msk/iac/modules/aws/ec2/msk-monitoring"

  instance_type     = "t3.small"
  aws_region        = var.aws_region
  role_name         = data.terraform_remote_state.role.outputs.name
  role_arn          = data.terraform_remote_state.role.outputs.arn
  subnet_id         = data.terraform_remote_state.vpc.outputs.public_subnet_az1_id
  bootstrap_server  = data.terraform_remote_state.cluster.outputs.bootstrap_brokers_sasl_iam
  key_name          = "ec2-kafka"
  security_groups   = [
    data.terraform_remote_state.ssh_sg.outputs.id,
    data.terraform_remote_state.msk_sg.outputs.id,
    data.terraform_remote_state.msk_akhq_monitoring_sg.outputs.id,
    data.terraform_remote_state.msk_redpanda_monitoring_sg.outputs.id,
  ]
}
