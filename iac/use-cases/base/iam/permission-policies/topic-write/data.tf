data "terraform_remote_state" "cluster" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/msk/cluster/terraform.tfstate"
  }
}
