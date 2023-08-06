resource "aws_lb_target_group" "lb_targets" {
  vpc_id      = aws_vpc.workspacePro_vpc.id
  name        = "lb-targets"
  target_type = "instance"
  port        = 3000
  protocol    = "HTTP"

  health_check {
    enabled             = true
    interval            = 30
    path                = "/"
    port                = "3000"
    protocol            = "HTTP"
    healthy_threshold   = 5
    unhealthy_threshold = 3
    matcher             = "200"
  }
  tags = {}
}

resource "aws_lb" "application_load_balancer01" {
  name               = ""
  ip_address_type    = "ipv4"
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.public_subnetA.id, aws_subnet.public_subnetB.id, aws_subnet.public_subnetC.id]
  security_groups    = [aws_security_group.sg_workspacePro_application_loadbalancer.id]
  tags               = {
    "Name" = "ec2-instance-backend", "created-by" = "terraform", Environment = "dev"
  }
}

resource "aws_lb_listener" "lb_http_listener" {
  port              = 80
  ##certificate_arn   = var.certificate_arn
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.application_load_balancer01.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_targets.arn
  }
}

resource "aws_lb_listener" "lb_https_listener" {
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = var.certificate_arn
  load_balancer_arn = aws_lb.application_load_balancer01.arn
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_targets.arn
  }
}

resource "aws_lb_target_group_attachment" "lb_target_attachment" {
  target_group_arn = aws_lb_target_group.lb_targets.arn
  target_id        = aws_instance.ec2_instance_application.id
}

