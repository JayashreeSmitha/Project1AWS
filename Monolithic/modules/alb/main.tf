resource "aws_lb" "app_lb" {
  name               = "my-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.security_groups
  subnets            = var.public_subnet_ids
  enable_deletion_protection = false

  tags = { Name = "app-lb" }
}

output "alb_arn" {
  value = aws_lb.app_lb.arn
}
