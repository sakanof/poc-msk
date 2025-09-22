data "terraform_remote_state" "topic_owner_policy" {
  backend = "local"
  config = {
    path = "/poc-msk/iac/use-cases/base/iam/permission-policies/topic-owner/terraform.tfstate"
  }
}
