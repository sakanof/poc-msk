data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../networking/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "cluster_config" {
  backend = "local"
  config = {
    path = "../cluster-config/terraform.tfstate"
  }
}

data "terraform_remote_state" "msk_sg" {
  backend = "local"
  config = {
    path = "../../networking/security-groups/msk-access/terraform.tfstate"
  }
}
