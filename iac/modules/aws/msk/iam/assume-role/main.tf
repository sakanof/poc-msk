data "aws_iam_policy_document" "this" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type        = "Service"
      identifiers = var.service_identifiers
    }
  }
}

resource "aws_iam_role" "this" {
  name                = "AssumeRole-${var.custom_name}"
  assume_role_policy  = data.aws_iam_policy_document.this.json
}