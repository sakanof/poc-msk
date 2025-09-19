locals {
  topic_name_normalized = var.topic_name == "*" ? "all" : var.topic_name
}

resource "aws_iam_policy" "read" {
  name        = "MskSubscriberReadPolicy-${var.aws_account}-${var.cluster_name}-${local.topic_name_normalized}"
  description = "IAM role that an EC2 instance can assume to Read from ${var.aws_account}-${var.cluster_uuid}-${var.topic_name} MSK topic."
  policy      = data.aws_iam_policy_document.policy.json
}
