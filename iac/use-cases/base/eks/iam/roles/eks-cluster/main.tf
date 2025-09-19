module "eks_cluster_role" {
  source        = "../../../../../../modules/aws/eks/iam/eks-cluster"

  aws_account   = var.aws_account
  aws_region    = var.aws_region
  cluster_name  = var.eks_cluster_name
}
