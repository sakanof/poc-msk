locals {
  topic_name = data.terraform_remote_state.topic_read_policy.outputs.topic_name == "*" ? "all" : data.terraform_remote_state.topic_read_policy.outputs.topic_name
}

module "topic_read_role" {
  source              = "../../../../../modules/aws/msk/iam/assume-role"

  custom_name         = "bla-read"
  #custom_name         = "${local.topic_name}-read"
  service_identifiers = ["ec2.amazonaws.com"]
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = module.topic_read_role.name
  policy_arn = data.terraform_remote_state.topic_read_policy.outputs.policy_arn
}
