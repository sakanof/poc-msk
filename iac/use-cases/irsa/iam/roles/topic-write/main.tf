module "topic_write_role" {
  source          = "../../../../../modules/aws/msk/iam/irsa-role"

  issuer          = data.terraform_remote_state.eks_cluster.outputs.oidc_provider_url
  aws_account     = var.aws_account
  namespace       = "poc-aws-msk"
  service_account = "topic-write"
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = module.topic_write_role.name
  policy_arn = data.terraform_remote_state.topic_write_policy.outputs.policy_arn
}
