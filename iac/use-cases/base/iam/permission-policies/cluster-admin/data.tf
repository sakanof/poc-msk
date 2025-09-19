data "terraform_remote_state" "msk" {
  backend = "local"
  config = {
    path = "../../../msk/cluster/terraform.tfstate"
  }
}
