data "terraform_remote_state" "topic_read_policy" {
  backend = "local"
  config = {
    path = "../../../../base/iam/permission-policies/topic-read/terraform.tfstate"
  }
}
