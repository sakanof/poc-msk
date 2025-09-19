data "terraform_remote_state" "eks_cluster" {
  backend = "local"
  config = {
    path = "../../../../base/eks/cluster/terraform.tfstate"
  }
}

data "terraform_remote_state" "topic_read_policy" {
  backend = "local"
  config = {
    path = "../../../../base/iam/permission-policies/topic-read/terraform.tfstate"
  }
}