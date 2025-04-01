resource "aws_lb" "this" {
  name               = var.alb_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.subnets

  tags = {
    Name = var.alb_name
  }
}

# Frontend target group
resource "aws_lb_target_group" "frontend_tg" {
  name     = "${var.alb_name}-frontend"
  port     = var.frontend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = var.frontend_health_check_path
    matcher             = "200-299"
  }
}

# Backend target group
resource "aws_lb_target_group" "backend_tg" {
  name     = "${var.alb_name}-backend"
  port     = var.backend_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    path                = var.backend_health_check_path
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.frontend_tg.arn
  }
}

# Listener rule for backend routing: requests to /api/* will be forwarded to backend target group
resource "aws_lb_listener_rule" "backend_rule" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backend_tg.arn
  }

  condition {
    host_header {
      values = var.backend_host_header != "" ? [var.backend_host_header] : []
    }
  }

  condition {
    path_pattern {
      values = [var.backend_path_pattern]
    }
  }
}
