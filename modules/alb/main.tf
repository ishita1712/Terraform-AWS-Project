# create application load balancer
resource "aws_lb" "application_load_balancer" {
  name                       = "${var.project-name}-alb"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [var.alb_security_group_id]
  subnets                    = [var.public_subnet_az1_id, var.public_subnet_az2_id]
  enable_deletion_protection = false
  ip_address_type            = "ipv4"
  tags = {
    Name = "${var.project-name}-alb"
  }
}

# create target group
resource "aws_lb_target_group" "alb_target_group" {
  name        = "${var.project-name}-tg"
  target_type = "instance" # It can also be of type "alb", "instnace" & "lambda"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    enabled             = true
    interval            = 300
    path                = "/"
    timeout             = 60
    matcher             = 200
    healthy_threshold   = 5
    unhealthy_threshold = 5
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_target_group_attachment" "test" {
  target_group_arn = aws_lb_target_group.alb_target_group.arn
  # target_id        = aws_lb.application_load_balancer.arn #(when target type is alb)
  target_id = var.ec2_instance #(when target type is "instance")
  port      = 80
}

# create a listener on port 80 with redirect action
resource "aws_lb_listener" "alb_http_listener" {
  load_balancer_arn = aws_lb.application_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}
