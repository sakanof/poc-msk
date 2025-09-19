data "aws_iam_policy_document" "policy" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:Connect",
    ]
    resources = [
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:cluster/*/${var.cluster_uuid}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:ReadData",
      "kafka-cluster:DescribeTopic",
      "kafka-cluster:DescribeTopicDynamicConfiguration",
    ]
    resources = [
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:topic/*/*/${var.topic_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:DescribeGroup",
      "kafka-cluster:AlterGroup",
      "kafka-cluster:DeleteGroup",
    ]
    resources = [
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:group/*/${var.cluster_uuid}/${var.group_name}"
    ]
  }
}