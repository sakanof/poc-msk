data "terraform_remote_state" "vpc" {
  backend = "local"
  config = {
    path = "../../../base/networking/vpc/terraform.tfstate"
  }
}

data "terraform_remote_state" "ssh_sg" {
  backend = "local"
  config = {
    path = "../../../base/networking/security-groups/ssh-access/terraform.tfstate"
  }
}

data "terraform_remote_state" "msk_sg" {
  backend = "local"
  config = {
    path = "../../../base/networking/security-groups/msk-access/terraform.tfstate"
  }
}

data "terraform_remote_state" "cluster" {
  backend = "local"
  config = {
    path = "../../../base/msk/cluster/terraform.tfstate"
  }
}

data "terraform_remote_state" "role" {
  backend = "local"
  config = {
    path = "../../iam/roles/topic-read/terraform.tfstate"
  }
}