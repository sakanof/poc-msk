module "ec2_instance" {
  source            = "/poc-msk/iac/modules/aws/ec2/kafka-client"

  instance_type     = "t3.small"
  role_name         = data.terraform_remote_state.role.outputs.name
  subnet_id         = data.terraform_remote_state.vpc.outputs.public_subnet_az1_id
  bootstrap_server  = data.terraform_remote_state.cluster.outputs.bootstrap_brokers_sasl_iam
  topic_name        = "test-topic"
  group_name        = "test-group"
  tag_name          = "poc-aws-msk-topic-owner"
  client_type       = "owner"
  key_name          = "ec2-kafka"
  security_groups   = [
    data.terraform_remote_state.ssh_sg.outputs.id,
    data.terraform_remote_state.msk_sg.outputs.id
  ]
}
