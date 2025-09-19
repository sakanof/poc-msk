locals {
  topic_name_normalized = var.topic_name == "*" ? "all" : var.topic_name
}

resource "aws_iam_policy" "policy" {
  name        = "MskResourceOwnerPolicy-${var.aws_account}-${var.cluster_name}-${local.topic_name_normalized}"
  description = "Policy granting Resource Owner Permissions to ${var.aws_account}-${var.cluster_uuid}-${var.topic_name} MSK Topic."
  policy      = data.aws_iam_policy_document.resource_owner.json
}
