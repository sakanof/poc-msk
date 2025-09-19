module "subscriber_topic_owner_role" {
  source          = "../../../../../modules/aws/msk/iam/irsa-role"

  issuer          = data.terraform_remote_state.eks_cluster.outputs.oidc_provider_url
  aws_account     = var.aws_account
  namespace       = "poc-aws-msk"
  service_account = "topic-owner"
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = module.subscriber_topic_owner_role.name
  policy_arn = data.terraform_remote_state.topic_owner_policy.outputs.policy_arn
}