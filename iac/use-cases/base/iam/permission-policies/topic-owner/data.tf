data "terraform_remote_state" "cluster" {
  backend = "local"
  config = {
    path = "../../../msk/cluster/terraform.tfstate"
  }
}
