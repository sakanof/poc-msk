module "aws_msk_configuration" {
  source        = "../../../../modules/aws/msk/cluster-config"

  name          = "poc-aws-msk-config"
  kafka_version = "3.6.0"
}
