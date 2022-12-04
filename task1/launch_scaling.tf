#AWS LAUNCH CONFIG

resource "aws_key_pair" "deployer" {
  key_name   = "terraform_deployer"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_launch_configuration" "launch_config" {
  name_prefix                 = "assessmetn-web-launch-config"
  image_id                    = "${var.ami}"
  instance_type               = "${var.instance_type}"
  key_name                    = "${aws_key_pair.deployer.id}"
  security_groups             = ["${aws_security_group.webserver_securitygroup.id}"]
  user_data = filebase64("${path.module}/provision.sh")

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_autoscaling_group" "assessment_autoscaling_group" {
  launch_configuration = "${aws_launch_configuration.launch_config.id}"
  min_size             = "${var.autoscaling_group_min_size}"
  max_size             = "${var.autoscaling_group_max_size}"
  target_group_arns    = ["${aws_lb_target_group.ALB_Target.arn}"]
  depends_on          = [aws_lb.alb]
  vpc_zone_identifier  = aws_subnet.private.*.id

  tag {
    key                 = "Name"
    value               = "assessment-autoscaling-group"
    propagate_at_launch = true
  }
}


# Create Target group

resource "aws_lb_target_group" "ALB_Target" {
  name       = "alb-target"
  depends_on = [aws_vpc.assessment-vpc]
  port       = 80
  protocol   = "HTTP"
  vpc_id     = aws_vpc.assessment-vpc.id
  health_check {
    interval            = 70
    path                = "/index.html"
    port                = 80
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
  tags = {
    name    = "alb-target"
    Project = "assessment-secgroup"
  }

}


# Create ALB Listener

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ALB_Target.arn
  }
  tags = {
    name    = "front_end"
    Project = "assessment-secgroup"
  }
}
