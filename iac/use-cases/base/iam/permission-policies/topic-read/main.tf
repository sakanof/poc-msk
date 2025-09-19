module "read" {
  source        = "../../../../../modules/aws/msk/iam/permission-policies/topic-read"

  aws_region    = var.aws_region
  aws_account   = var.aws_account
  cluster_uuid  = data.terraform_remote_state.cluster.outputs.cluster_uuid
  cluster_name  = data.terraform_remote_state.cluster.outputs.cluster_name
  topic_name    = var.topic_name
  group_name    = var.group_name
}
