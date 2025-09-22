module "cluster_admin" {
  source      = "/poc-msk/iac/modules/aws/msk/iam/permission-policies/cluster-admin"

  aws_account = var.aws_account
}
