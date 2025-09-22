locals {
  topic_name = data.terraform_remote_state.topic_owner_policy.outputs.topic_name == "*" ? "all" : data.terraform_remote_state.topic_owner_policy.outputs.topic_name
}

module "topic_topic_owner_role" {
  source              = "/poc-msk/iac/modules/aws/msk/iam/assume-role"

  custom_name         = "${local.topic_name}-topic_owner"
  service_identifiers = ["ec2.amazonaws.com"]
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = module.topic_topic_owner_role.name
  policy_arn = data.terraform_remote_state.topic_owner_policy.outputs.policy_arn
}
