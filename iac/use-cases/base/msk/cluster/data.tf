data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/networking/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "cluster_config" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/msk/cluster-config/terraform.tfstate"
  }
}

data "terraform_remote_state" "msk_sg" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/networking/security-groups/msk-access/terraform.tfstate"
  }
}
