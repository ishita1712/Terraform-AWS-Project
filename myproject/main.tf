# configure provider

provider "aws" {
  region = var.region
}

# Reference VPC module

module "vpc" {
  source                       = "../modules/vpc"
  region                       = var.region
  project-name                 = var.project-name
  vpc_cidr                     = var.vpc_cidr
  public_subnet_az1_cidr       = var.public_subnet_az1_cidr
  public_subnet_az2_cidr       = var.public_subnet_az2_cidr
  private_app_subnet_az1_cidr  = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr  = var.private_app_subnet_az2_cidr
  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr

}

# Reference SG module

module "security_group" {
  source = "../modules/security-groups"
  vpc_id = module.vpc.vpc_id
}

# Reference EC2 module
/*
module "ec2" {
  source = "../modules/ec2"
  ec2_ami = var.ec2_ami
  ec2_instance_type = var.ec2_instance_type
  public_subnet_az1_cidr = module.vpc.public_subnet_az1_id
  alb_security_group_id  = module.security_group.alb_security_group_id
  key_name               = module.key-pair.key_name
}
*/


# Reference ALB module
module "alb" {
  source                = "../modules/alb"
  ec2_instance          = module.asg.asg_instance
  project-name          = module.vpc.project_name
  alb_security_group_id = module.security_group.alb_security_group_id
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  vpc_id                = module.vpc.vpc_id
}

# Reference ASG module
module "asg" {
  source                = "../modules/asg"
  ec2_ami               = var.ec2_ami
  ec2_instance_type     = var.ec2_instance_type
  min_size              = var.min_size
  desired_capacity      = var.desired_capacity
  max_size              = var.desired_capacity
  alb_security_group_id = module.security_group.alb_security_group_id
  project-name          = module.vpc.project_name
  alb_target_group_arn  = module.alb.alb_target_group_arn
  public_subnet_az1_id  = module.vpc.public_subnet_az1_id
  public_subnet_az2_id  = module.vpc.public_subnet_az2_id
  key_name              = module.key-pair.key_name
  asg_resource          = module.asg.asg_resource
}

# Reference key-pair module
module "key-pair" {
  source   = "../modules/key-pair"
  key_name = var.key_name
}