resource "aws_lb" "alb" {
  name               = "sg-alb-assessment"
  internal           = false
  depends_on          = [aws_s3_bucket.s3_bucket]
  load_balancer_type = "application"
  subnets            = aws_subnet.public.*.id
  security_groups    = [aws_security_group.lb.id]

  tags = {
    name    = "assessment-alb"
    Project = "assessment-secgroup"
  }
}
