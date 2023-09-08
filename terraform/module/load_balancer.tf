resource "aws_default_vpc" "default_vpc" {
}
resource "aws_ecs_cluster" "application_cluster" {
  name = "${var.project_name}-cluster-${var.env}"
}

resource "aws_default_subnet" "application_subnet_a" {
  availability_zone = "eu-west-2a"
}

resource "aws_default_subnet" "application_subnet_b" {
  availability_zone = "eu-west-2b"
}

resource "aws_default_subnet" "application_subnet_c" {
  availability_zone = "eu-west-2c"
}

resource "aws_alb" "application_load_balancer" {
  name               = "${var.project_name}-lb-${var.env}"
  load_balancer_type = "application"
  subnets = [
    "${aws_default_subnet.application_subnet_a.id}",
    "${aws_default_subnet.application_subnet_b.id}",
    "${aws_default_subnet.application_subnet_c.id}"
  ]
  security_groups = ["${aws_security_group.application_load_balancer_security_group.id}"]
}

resource "aws_security_group" "application_load_balancer_security_group" {
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_target_group" "application_target_group" {
  name        = "${var.project_name}-tg-${var.env}"
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  vpc_id      = aws_default_vpc.default_vpc.id
  health_check {
    matcher             = "200,301,302"
    path                = "/"
    interval            = 300
    timeout             = 120
    unhealthy_threshold = 5
  }
}

resource "aws_lb_listener" "application_http" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.application_target_group.arn
  }
}


resource "aws_security_group" "application_service_security_group" {
  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = ["${aws_security_group.application_load_balancer_security_group.id}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
