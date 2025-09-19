resource "aws_iam_openid_connect_provider" "eks_oidc_provider" {
  url = var.oidc_provider_url

  client_id_list = [
    "sts.amazonaws.com"
  ]

  tags = {
    Name = "EKSOIDCProvide-poc-aws-msk"
  }
}

