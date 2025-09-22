data "terraform_remote_state" "topic_write_policy" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/iam/permission-policies/topic-write/terraform.tfstate"
  }
}
