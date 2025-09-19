data "terraform_remote_state" "topic_owner_policy" {
  backend = "local"
  config = {
    path = "../../../../base/iam/permission-policies/topic-owner/terraform.tfstate"
  }
}