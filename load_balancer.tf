# ============================================================
# APPLICATION LOAD BALANCER
# ============================================================

resource "aws_lb" "app" {
  name               = "${local.project_name}-alb"
  internal           = false
  load_balancer_type = "application"

  security_groups = [aws_security_group.alb.id]

  subnets = module.network.public_subnet_ids

  tags = {
    Name = "${local.project_name}-alb"
  }
}


# ============================================================
# TARGET GROUP
# ============================================================

resource "aws_lb_target_group" "app" {
  name     = "terraform-app-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.network.vpc_id

  health_check {
    path                = "/health"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "terraform-app-tg"
  }
}


# ============================================================
# HTTP LISTENER
# ============================================================

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}