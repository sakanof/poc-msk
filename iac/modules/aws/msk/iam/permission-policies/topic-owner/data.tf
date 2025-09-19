data "aws_iam_policy_document" "resource_owner" {
  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:Connect",
      "kafka-cluster:WriteDataIdempotently",
    ]
    resources = [
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:cluster/*/${var.cluster_uuid}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:CreateTopic",
      "kafka-cluster:DescribeTopic",
      "kafka-cluster:AlterTopic",
      "kafka-cluster:AlterTopicDynamicConfiguration",
      "kafka-cluster:DeleteTopic",
      "kafka-cluster:DescribeTopicDynamicConfiguration",
      "kafka-cluster:ReadData",
      "kafka-cluster:WriteData"
    ]
    resources = [
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:topic/*/*/${var.topic_name}"
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "kafka-cluster:DescribeTransactionalId",
      "kafka-cluster:AlterTransactionalId",
    ]
    # The ARN format for a transactional ID typically includes a slash
    resources = [
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:transactional-id/*/${var.cluster_uuid}/*"
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
      "arn:aws:kafka:${var.aws_region}:${var.aws_account}:group/*/${var.cluster_uuid}/*"
    ]
  }
}