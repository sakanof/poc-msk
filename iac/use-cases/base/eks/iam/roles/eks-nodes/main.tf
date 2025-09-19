module "eks_cluster_node_role" {
  source                = "../../../../../../modules/aws/eks/iam/eks-nodes"

  aws_account   = var.aws_account
  aws_region    = var.aws_region
  cluster_name  = var.eks_cluster_name

}