# vpc module variables
variable "region" {}
variable "project-name" {}
variable "vpc_cidr" {}
variable "public_subnet_az1_cidr" {}
variable "public_subnet_az2_cidr" {}
variable "private_app_subnet_az1_cidr" {}
variable "private_app_subnet_az2_cidr" {}
variable "private_data_subnet_az1_cidr" {}
variable "private_data_subnet_az2_cidr" {}
variable "key_name" {}
variable "ec2_ami" {}
variable "ec2_instance_type" {}
variable "min_size" {}
variable "desired_capacity" {}
variable "max_size" {}