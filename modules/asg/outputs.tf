data "aws_instances" "test" {

  instance_state_names = ["running"]
  depends_on           = [var.asg_resource]
}

output "asg_instance" {
  value = data.aws_instances.test.ids[0]
}
output "asg_resource" {
  value = aws_autoscaling_group.alb_asg
}
