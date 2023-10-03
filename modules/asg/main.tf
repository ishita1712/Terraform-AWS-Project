resource "aws_launch_configuration" "asg_launch_config" {
  name_prefix                 = "${var.project-name}-launch-config"
  image_id                    = var.ec2_ami
  instance_type               = var.ec2_instance_type
  key_name                    = var.key_name
  security_groups             = [var.alb_security_group_id]
  associate_public_ip_address = true
  user_data                   = file("../modules/ec2/script.sh")
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "alb_asg" {
  name                 = "${var.project-name}-asg"
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  health_check_type    = "ELB"
  target_group_arns    = [var.alb_target_group_arn]
  launch_configuration = aws_launch_configuration.asg_launch_config.name
  vpc_zone_identifier  = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  # Required to redeploy without an outage.
  lifecycle {
    create_before_destroy = true
  }
  # depends_on = [var.alb_resource]
}