# launch the ec2 instance and install website

resource "aws_instance" "ec2_instance" {
  ami             = var.ec2_ami
  instance_type   = var.ec2_instance_type
  subnet_id       = var.public_subnet_az1_cidr
  security_groups = [var.alb_security_group_id]
  key_name        = var.key_name
  user_data       = file("../modules/ec2/script.sh")

  tags = {
    Name = "Terraform EC2 Instance"
  }
}


