resource "aws_iam_role" "eks_role" {
  name               = "EKSRole-${var.aws_account}-poc-aws-msk"
  assume_role_policy = data.aws_iam_policy_document.eks_trust_policy.json
  description        = "IAM Role for the owner of ${var.cluster_name} EKS Cluster."
}

resource "aws_iam_role_policy_attachment" "policy_attachment" {
  role       = aws_iam_role.eks_role.id
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
