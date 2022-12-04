# Security Group Creation for ALB

resource "aws_security_group" "lb" {
  name   = "ec2-alb-security-group-assessment"
  vpc_id = aws_vpc.assessment-vpc.id

  ingress {
    protocol    = "tcp"
    from_port   = 80
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name    = "alb_secgroup"
    Project = "assessment-secgroup"
  }
}

# Security Group Creation for Webserverr

resource "aws_security_group" "webserver_securitygroup" {
  name   = "webserver_securitygroup"
  vpc_id = aws_vpc.assessment-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["10.0.0.0/16"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name    = "webserver_securitygroup"
    Project = "assessment-secgroup"
  }
}
