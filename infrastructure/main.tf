module "network" {
  source               = "./modules/network"
  region               = "us-east-1"
  vpc_cidr             = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.10.0/24"
  private_subnet_cidr = "10.0.30.0/24"
  availability_zone   = ["us-east-1a"]
}
module "compute" {
  source              = "./modules/compute"
  private_subnet_id   = module.network.private_subnets_id
  security_group_id   = module.network.default_sg_id
  AWS_ACCESS_KEY      = var.AWS_ACCESS_KEY
  AWS_SECRET_KEY      = var.AWS_SECRET_KEY
}

module "apigateway" {
  source              = "./modules/apigateway"
  lambda_invoke_arn   = module.compute.lambda_invoke_arn
  lambda_name         = module.compute.lambda_name
}