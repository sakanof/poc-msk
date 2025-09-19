module "vpc" {
  source     = "../../../../modules/aws/networking/vpc"

  vpc_name                = "poc-aws-msk"
  eks_name                = "poc-aws-msk"

  cidr_block              = "10.0.0.0/16"
  public_az1_cidr_block   = "10.0.0.0/20"
  public_az2_cidr_block   = "10.0.16.0/20"
  public_az3_cidr_block   = "10.0.32.0/20"
  private_az1_cidr_block  = "10.0.48.0/20"
  private_az2_cidr_block  = "10.0.64.0/20"
  private_az3_cidr_block  = "10.0.80.0/20"
}
