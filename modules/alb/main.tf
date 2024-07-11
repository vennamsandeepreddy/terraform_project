
resource "aws_lb" "api" {
  name               = var.lb_name
  load_balancer_type = var.load_balancer_type
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.alb_sg.id]
  tags = {
    name = "Load Balancer for API "
    env = var.env
  }
}

resource "aws_security_group" "alb_sg" {
  name = "alb-sg"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.aws_lb_listener_port
    to_port     = var.aws_lb_listener_port
    protocol    = var.aws_lb_listener_protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.api.arn
  port              = var.aws_lb_listener_port
  protocol          = var.aws_lb_listener_protocol
  ssl_policy        = var.aws_lb_listener_ssl_policy
  certificate_arn   = var.aws_acm_certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

resource "aws_lb_target_group" "api" {
  name        = var.aws_lb_target_group_name
  port        = var.aws_lb_target_group_port
  protocol    = var.aws_lb_target_group_protocol
  vpc_id      = var.vpc_id
  target_type = "ip"
 health_check {
    path                = "/"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
  tags = {
    name = "target group for API "
    env = var.env
  }
}