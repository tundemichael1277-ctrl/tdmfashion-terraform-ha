# AWS Application Load Balancer
resource "aws_lb" "tdmfashion_alb" {
  name               = "tdmfashion-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.tdmfashion_ha_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false # Set to true for production environments

  tags = {
    Environment = "dev"
  }
}

# Target Group for routing traffic to instances
resource "aws_lb_target_group" "tdmfashion_target_group" {
  name        = "tdmfashion-target-group"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance" # Can also be "ip" or "lambda"
  health_check {
    enabled             = true
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

# ALB Listener to forward incoming requests to the target group
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.tdmfashion_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tdmfashion_target_group.arn
  }
}
