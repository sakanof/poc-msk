module "eks_cluster" {
  source            = "../../../../modules/aws/eks/cluster"

  eks_version       = var.eks_version
  eks_cluster_name  = var.eks_cluster_name
  role_arn          = data.terraform_remote_state.eks_role.outputs.arn
  subnet_ids        = data.terraform_remote_state.vpc.outputs.private_subnets
}