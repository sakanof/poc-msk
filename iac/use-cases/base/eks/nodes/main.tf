module "eks_nodes" {
  source        = "../../../../modules/aws/eks/nodes"

  eks_version   = var.eks_version
  name          = data.terraform_remote_state.eks_cluster.outputs.cluster_name
  role_arn      = data.terraform_remote_state.eks_nodes_role.outputs.arn
  subnet_ids    = data.terraform_remote_state.vpc.outputs.private_subnets
}
