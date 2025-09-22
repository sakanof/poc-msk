data "terraform_remote_state" "eks" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/eks/cluster/terraform.tfstate"
  }
}
