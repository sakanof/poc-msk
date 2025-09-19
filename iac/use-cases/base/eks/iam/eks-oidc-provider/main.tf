module "eks_oidc_provider" {
  source            = "../../../../../modules/aws/eks/iam/eks-oidc-provider"

  oidc_provider_url = data.terraform_remote_state.eks.outputs.oidc_provider_url
}
