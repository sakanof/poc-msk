resource "aws_iam_policy" "policy" {
  name          = "MskAdminPolicy-${var.aws_account}"
  description   = "Policy granting MSK Admin Permissions to ${var.aws_account} account."
  policy        = data.aws_iam_policy_document.msk_admin.json
}
