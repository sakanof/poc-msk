data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/networking/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "eks_role" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/eks/iam/roles/eks-cluster/terraform.tfstate"
  }
}
