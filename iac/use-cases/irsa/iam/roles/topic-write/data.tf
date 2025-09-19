data "terraform_remote_state" "eks_cluster" {
  backend = "local"
  config = {
    path = "../../../../base/eks/cluster/terraform.tfstate"
  }
}

data "terraform_remote_state" "topic_write_policy" {
  backend = "local"
  config = {
    path = "../../../../base/iam/permission-policies/topic-write/terraform.tfstate"
  }
}