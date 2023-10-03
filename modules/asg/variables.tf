variable "ec2_ami" {}
variable "ec2_instance_type" {}

variable "min_size" {}
variable "desired_capacity" {}
variable "max_size" {}

variable "key_name" {}
variable "alb_security_group_id" {}
variable "project-name" {}
variable "public_subnet_az1_id" {}
variable "public_subnet_az2_id" {}
variable "alb_target_group_arn" {}

variable "asg_resource" {}